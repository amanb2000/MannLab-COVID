# MannLab-COVID

Computer vision and machine learning modules for the MannLab COVID wearable initiative. Built with OpenCV in Python3.
Requirements can be found in `requirements.txt`. Run `pip3 install -r requirements.txt` to install.

## Goals

### Image Processing

Create a set of image processing scripts that take in `optical`, `infrared`, and `radar` data to achieve the following objectives:

1. Recognize the presence of each person in the field of view.
2. Extract COVID-19 related features including cough, shortness of breath, fever, and heart rate (CSF+).
3. Give the wearer real-time information based on each feature on the people in their surroundings.

### Machine Learning

Create a set of algorithms that are able to determine the wearer's COVID-19 risk based on weighted absement and presement values and the extracted features outlined above. Algorithms that are able to more accurately diagnose/evaluate the risk of those in the viscinity are also of interest.

## Folder Structure

1. `CV`: For computer vision related scripts and files.
2. `media`: For sample data (IR, Radar, and Optical).

## File Structure

### `static_detection.py`

For the processing of static photos. Currently recognizes faces and assigns sample data for CSF (cough, shortness of breath, and fever) readings. 

`Next steps`: Pending sample data that has IR data AND optical data on the same target, a proof-of-concept script will be created that can approximate the person's temperature based on the maximum IR readings corresponding to the recognized face.

### `live_detection.py`

Script that can do anything that the `static_detection` script does in real time on camera stream input.
