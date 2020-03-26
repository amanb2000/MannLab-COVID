import cv2
import numpy as np

face_cascade = cv2.CascadeClassifier('assets/haarcascade_frontalface_alt2.xml')
font = cv2.FONT_HERSHEY_SIMPLEX
line_height = 100
fractional_font_size = 1/20

im_name = 'adam'

img = cv2.imread(str('../media/samples/'+im_name+'.jpg'), 0) # flag can be 0, 1, -1 == grayscale, color, original
print(img.shape) # if the images DNE, img will be None

font_size = fractional_font_size * max(img.shape)

### Detecting the Face in the Photo ###

face_detect = face_cascade.detectMultiScale(img, scaleFactor=1.1, minNeighbors=10)

for (x, y, w, h) in face_detect:
    cv2.rectangle(img, (x, y), (x+w, y+h), (255, 100, 100), 2)

    cv2.putText(img,'Cough: 12.4%, Low Risk',(x+w+2, y+line_height), font, 3,(255,255,255),5,cv2.LINE_AA)
    cv2.putText(img,'Shortness of Breath: 30.2%, Medium Risk',(x+w+2, y+line_height*2), font, 3,(255,255,255),5,cv2.LINE_AA)
    cv2.putText(img,'Temperature: 37.1 C, Low Risk',(x+w+2, y+line_height*3), font, 3,(255,255,255),5,cv2.LINE_AA)
    cv2.putText(img,'Heart Rate: 72 BPM, Low Risk',(x+w+2, y+line_height*4), font, 3,(255,255,255),5,cv2.LINE_AA)
    cv2.putText(img,'Risk Assessment: 10.2%, Low Risk',(x+w+2, y+line_height*6), font, 3,(255,255,255),8,cv2.LINE_AA)

    break

### Showing the Images ###

cv2.imshow('image', img)

cv2.waitKey(0) # the argument is the number of milliseconds before auto-close. 0 makes it infinite.

cv2.destroyAllWindows()

cv2.imwrite('../media/results/'+im_name+'.png', img)

cv2.destroyAllWindows()
