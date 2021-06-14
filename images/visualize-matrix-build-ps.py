#!/usr/bin/env python
import time
import sys
import argparse
from PIL import Image
import time
import pymysql.cursors
import os
from urllib.request import urlopen
from urllib.parse import urlparse


class VisualizeMatrixBuild(object):
    def __init__(self, *args, **kwargs):
        self.parser = argparse.ArgumentParser()
        self.parser.add_argument("--max-job-x", help="max-job-x", default=8, type=int)
        self.parser.add_argument("--max-job-y", help="max job y", default=4, type=int)
        self.parser.add_argument("--max-x", help="max x pixels", default=32, type=int)
        self.parser.add_argument("--max-y", help="max y pixels", default=16, type=int)
        self.parser.add_argument("--job-x", help="job x", default=1, type=int)
        self.parser.add_argument("--job-y", help="job y", default=1, type=int)
        self.parser.add_argument("--environment", help="environment", default="barfoo", type=str)
        self.parser.add_argument("--image-file", help="image file location", default="images/static_image.jpg", type=str)
        self.parser.add_argument("--duration", help="job in milliseconds", default="5000", type=int)
        self.args = self.parser.parse_args()

    def run(self):
        maxX = self.args.max_x
        maxY = self.args.max_y

        pixelsX = int (maxX/self.args.max_job_x)
        pixelsY = int (maxY/self.args.max_job_y)

        offsetX = (self.args.job_x-1) * pixelsX
        offsetY = (self.args.job_y-1) * pixelsY

        numberPixels = pixelsX * pixelsY

        environment = self.args.environment
        duration = self.args.duration

        sleepBetweenPixels = duration / numberPixels

        image_file = self.args.image_file
        if image_file.startswith("http"):
            image = Image.open(urlopen(image_file))
        else:
            image = Image.open(image_file)

        width, height = image.size

        if width != maxX and height != maxY:
            image.thumbnail((maxX, maxY), Image.ANTIALIAS)


        url = urlparse(os.environ.get('DATABASE_URL'))
        #print (url.username, url.password, url.hostname, url.port, url.path[1:])

        connection = pymysql.connect(user=url.username,password=url.password, host=url.hostname,port=url.port)
        cursor = connection.cursor()

        rgb_im = image.convert('RGB')
        width, height = rgb_im.size

        add_pixels = ("INSERT INTO matrix "
                        "(environment, job, lines ) "
                        "VALUES (%s, %s, %s)")
        values = ""
        for y in range(pixelsY):
            for x in range(pixelsX):
                realX=x+offsetX
                realY=y+offsetY
                r, g, b = rgb_im.getpixel((realX%width,realY%height))
                value=("%d,%d,%d,%d,%d")%(realX,realY,r,g,b)
                values+=value
                values+="\n"
            #if (y != 0 and y%8 == 0):
            #    hashKey = ("%d/%d/%d") % (self.args.job_x, self.args.job_y, y)
            #   cursor.execute(add_pixels, (environment, hashKey, values))
            #    connection.commit()
            #    values=""
        
            time.sleep(sleepBetweenPixels*pixelsX/1000)
        hashKey = ("job/%d/%d") % (self.args.job_x, self.args.job_y)
        cursor.execute(add_pixels, (environment, hashKey, values))
        
        connection.commit()


# Main function
if __name__ == "__main__":
    stream_pixels = VisualizeMatrixBuild()
    stream_pixels.run()
