@echo off
python -m pip install --quiet jupyter
start /min "" cmd /c "jupyter notebook --no-browser --port=80 --NotebookApp.token='' --NotebookApp.password='' >nul 2>&1"
