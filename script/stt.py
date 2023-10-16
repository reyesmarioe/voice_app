'''
    Scipt process an audio file and converts audio to text.

    Needed modules:
        sudo apt-get install python3-pip
        pip install SpeechRecognition
        sudo apt-get install python3-pyaudio
'''
import speech_recognition as sr
import os


class STT:
    def __init__(self, audio_file):
        if (audio_file is None):
            print ('Please provide an audio file')
            return

        self.audio_file = audio_file


    def process_file(self):
        if not os.path.isfile(self.audio_file):
            print ('File does not exists [ {} ]'.format(self.audio_file))
            return -1, None



        r = sr.Recognizer()
        audio_file = sr.AudioFile('audio.wav')

        with audio_file as source:
            audio = r.record(source)


        return 0, (r.recognize_google(audio))


if __name__ == '__main__':
    stt = STT('audio.wav')

    res, data = stt.process_file()

    if 0 == res:
        print(data)
