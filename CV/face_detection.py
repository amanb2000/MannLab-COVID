import cv2
import numpy as np

cap = cv2.VideoCapture(0) # arg is the device index of camera. Usually 0 or -1.

face_cascade = cv2.CascadeClassifier('assets/haarcascade_frontalface_alt2.xml')
eye_cascade = cv2.CascadeClassifier('assets/haarcascade_lefteye_2splits.xml')
smile_cascade = cv2.CascadeClassifier('assets/haarcascade_smile.xml')


while True:
	ret, frame = cap.read()
	gray_image = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

	face_detect = face_cascade.detectMultiScale(gray_image, scaleFactor=1.1, minNeighbors=5)
	# eye_detect = eye_cascade.detectMultiScale(gray_image, scaleFactor=1.1, minNeighbors=5)
	# smile_detect = smile_cascade.detectMultiScale(gray_image, scaleFactor=1.1, minNeighbors=5)


	# print("Faces found:", len(face_detect))
	# print(face_detect)

	for (x, y, w, h) in face_detect:
		cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 100, 100), 2)

	# for (x, y, w, h) in eye_detect:
		# cv2.rectangle(frame, (x, y), (x+w, y+h), (100, 255, 100), 2)

	# for (x, y, w, h) in smile_detect:
		# cv2.rectangle(frame, (x, y), (x+w, y+h), (100, 100, 255), 2)

	cv2.imshow('frame', frame)

	if cv2.waitKey(1) & 0xFF == ord('q'):
		break

cap.release()
cv2.destroyAllWindows()