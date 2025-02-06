import os
import librosa
import numpy as np
import hashlib

'''This Python script is designed to find and remove duplicate audio files within a specified 
directory based on their Mel-Frequency Cepstral Coefficients (MFCCs)'''

directory = '/home/erick/Desktop/audio'  # path of folder that contains the audio files



def calculate_mfcc_hash(filepath):
    """Calculates the MFCC hash of an audio file."""
    try:
        y, sr = librosa.load(filepath)
        mfcc = librosa.feature.mfcc(y=y, sr=sr)
        # Use a more robust hashing method (SHA256)
        hasher = hashlib.sha256()
        hasher.update(mfcc.tobytes())  # Hash the raw bytes
        return hasher.hexdigest()
    except Exception as e:  # Catch potential errors during audio processing
        print(f"Error processing {filepath}: {e}")
        return None  # Return None if there's an error


def find_and_remove_duplicates(directory, extensions=('.mp3', '.m4a', '.mp4')):
    """Finds and removes duplicate audio files based on MFCCs."""
    mfcc_dict = {}

    for filename in os.listdir(directory):
        filepath = os.path.join(directory, filename)
        if os.path.isfile(filepath) and filepath.lower().endswith(extensions):  # Case-insensitive extension check
            mfcc_hash = calculate_mfcc_hash(filepath)
            if mfcc_hash:  # Only proceed if hash calculation was successful
                if mfcc_hash in mfcc_dict:
                    mfcc_dict[mfcc_hash].append(filepath)
                else:
                    mfcc_dict[mfcc_hash] = [filepath]

    for mfcc_hash, filepaths in mfcc_dict.items():
        if len(filepaths) > 1:
            # Sort by modification time (newest first) to keep the most recent file
            filepaths.sort(key=os.path.getmtime, reverse=True)  # Sort newest to oldest
            keep_filepath = filepaths[0]
            files_to_delete = filepaths[1:]  # More descriptive variable name

            for filepath in files_to_delete:
                try:
                    os.remove(filepath)
                    print(f'Deleted file: {filepath}')
                except OSError as e: # Handle potential OS errors (permissions, etc.)
                   print(f"Error deleting {filepath}: {e}")


find_and_remove_duplicates(directory)