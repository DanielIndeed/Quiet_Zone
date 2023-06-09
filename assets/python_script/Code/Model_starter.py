import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import os

class MyHandler(FileSystemEventHandler):
    def on_modified(self, event):
        if os.stat(r"C:\Users\boscu\Code Projects\Keep On Hearing\e-nnovate\Android Phone\flutter_application_1\assets\python_script\Data\Notepads\Microphone\Microphone_values.txt").st_size != 0:
            exec(open(r"C:\Users\boscu\Code Projects\Keep On Hearing\e-nnovate\Android Phone\flutter_application_1\assets\python_script\Code\Data_processor_for_AI.py", mode="r", encoding="utf-8").read())

if __name__ == "__main__":
    event_handler = MyHandler()
    observer = Observer()
    path = r"C:\Users\boscu\Code Projects\Keep On Hearing\e-nnovate\Android Phone\flutter_application_1\assets\python_script\Data\Notepads\Microphone"
    observer.schedule(event_handler, path, recursive=False)
    observer.start()
    try:
        while True:
            time.sleep(5)
    except KeyboardInterrupt:
        observer.stop()
        print("done")
