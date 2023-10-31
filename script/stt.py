'''
    Scipt process an audio file and converts audio to text.

    Needed modules:
        sudo apt-get install python3-pip
        pip install SpeechRecognition
        sudo apt-get install python3-pyaudio
'''
import speech_recognition as sr
import os
import sys
import time
import json


class STT:
    def __init__(self, audio_file, text_file):
        self.data = {}
        self.text_file = text_file
        if (audio_file is None):
            print ('Please provide an audio file')
            return

        self.audio_file = audio_file


    def process_file(self):
        if not os.path.isfile(self.audio_file):
            print ('File does not exists [ {} ]'.format(self.audio_file))
            return -1, None


        startProcess = time.time()

        r = sr.Recognizer()
        audio_file = sr.AudioFile(self.audio_file)

        with audio_file as source:
            audio = r.record(source)


        data = r.recognize_google(audio)
        endProcess = time.time()
        if len(data) > 0: 
            self.data['text'] = data
            self.data['fileName'] = self.audio_file
            self.data['wordCount'] = len(data.split(' '))
            self.data['processingTime'] = '{:.2f} secs'.format(endProcess - startProcess)
                    
            return 0
        else:
            return 1

    def write_to_file(self):
        with open(self.text_file, 'w') as fp:
            fp.write(json.dumps(self.data, indent=2))


if __name__ == '__main__':

    if 3 > len(sys.argv):
        print('stt.py <audio_file> <text_file>')
        sys.exit() 

    stt = STT(sys.argv[1], sys.argv[2])

    res = stt.process_file()

    if 0 == res:
<<<<<<< Updated upstream
        stt.write_to_file()
=======
        stt.write_to_file()
>>>>>>> Stashed changes
