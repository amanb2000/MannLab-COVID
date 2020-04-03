import cv2
import numpy as np

face_cascade = cv2.CascadeClassifier('assets/haarcascade_frontalface_alt2.xml')
font = cv2.FONT_HERSHEY_SIMPLEX
line_height = 130
fractional_font_size = 1/20

im_name = 'No_IR_Flip'
im2_name = 'IR_Composit_Flip'

img = cv2.imread(str('../media/samples/'+im_name+'.jpg'), 0) # flag can be 0, 1, -1 == grayscale, color, original

im2 = cv2.imread(str('../media/samples/'+im2_name+'.jpg'), 1)

print(img.shape) # if the images DNE, img will be None

font_size = 5

### Detecting the Face in the Photo ###

face_detect = face_cascade.detectMultiScale(img, scaleFactor=1.1, minNeighbors=10)

cnt = 0


font_weight = 9

for (x, y, w, h) in face_detect:
    if cnt != 0:
        cv2.rectangle(im2, (x, y), (x+w, y+h), (255, 255, 255), 2)

        cv2.putText(im2,'C: 22.4%',(x+w+2, y+line_height), font, font_size,(255,255,255),font_weight,cv2.LINE_AA)
        cv2.putText(im2,'R: 12.2%',(x+w+2, y+line_height*2), font, font_size,(255,255,255),font_weight,cv2.LINE_AA)
        cv2.putText(im2,'TMP: 37.1 C',(x+w+2, y+line_height*3), font, font_size,(255,255,255),font_weight,cv2.LINE_AA)
        cv2.putText(im2,'HR: 72 BPM',(x+w+2, y+line_height*4), font, font_size,(255,255,255),font_weight,cv2.LINE_AA)
        cv2.putText(im2,'HRV: 1 BPMM',(x+w+2, y+line_height*5), font, font_size,(255,255,255),font_weight,cv2.LINE_AA)
        cv2.putText(im2,'D: 2.2m',(x+w+2, y+line_height*6), font, font_size,(255,255,255),font_weight,cv2.LINE_AA)

        cv2.putText(im2,'Risk: 15.2%',(x+w+2, int(y+line_height*7.3)), font, font_size+.2,(100,255,100),font_weight,cv2.LINE_AA)

    cnt += 1
    

### Showing the Images ###

cv2.imshow('image', im2)

cv2.waitKey(0) # the argument is the number of milliseconds before auto-close. 0 makes it infinite.

cv2.destroyAllWindows()

cv2.imwrite('../media/results/'+im2_name+'.png', im2)

cv2.destroyAllWindows()
