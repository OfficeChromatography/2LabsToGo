from django.db.models import ImageField
import cv2
import numpy as np
from app.settings import MEDIA_ROOT
import logging

class HDR:

    def __init__(self,images,warp_mode,iterations):
        self.images = images
        self.warp_mode = warp_mode
        self.iterations = iterations

        self.grey_images=[]
        self.image_size = 0
        self.warp_matrix = None

        self.aligned_images = []
        self.termination_eps = None
        self.criteria = None

        self.results_file_path = f'{MEDIA_ROOT}/hdr/results/last_mertens_aligned.jpeg'

    def process_images(self):
        self.get_grey_images()
        self.get_size()
        self.get_warp_matrix()
        self.get_criteria()
        try:
            self.get_aligned_images()
            self.mertens()
            return self.results_file_path
        except cv2.error as e:
            logging.critical('There was an error trying to get images, may be to different? are they of the same size?')
            return None


    def get_grey_images(self):
        # Convert to grey scale
        for i in self.images:
            self.grey_images.append(cv2.cvtColor(i,cv2.COLOR_BGR2GRAY))

    def get_size(self):
        # Find size of 1 of the images
        self.image_size = self.grey_images[0].shape

    def get_warp_matrix(self):
        # Define 2x3 or 3x3 matrices and initialize the matrix to identity
        if self.warp_mode ==  cv2.MOTION_HOMOGRAPHY:
            self.warp_matrix = np.eye(3, 3, dtype=np.float32)
        else:
            self.warp_matrix = np.eye(2, 3, dtype=np.float32)

    def get_criteria(self):
        # Specify the threshold of the increment
        # in the correlation coefficient between two iterations
        self.termination_eps = 1e-10;
        self.criteria = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, self.iterations,  self.termination_eps)

    def get_aligned_images(self):
        for i in range(1,len(self.images)):
            (cc, warp_matrix) = cv2.findTransformECC(self.grey_images[0],
                                                     self.grey_images[i],
                                                     self.warp_matrix,
                                                     self.warp_mode,
                                                     self.criteria,
                                                     self.grey_images[0],
                                                     5)
            self.align_image(self.images[i])

    def align_image(self, image):
        if self.warp_mode == cv2.MOTION_HOMOGRAPHY:
            self.aligned_images.append(cv2.warpPerspective(image,
                                                            self.warp_matrix,
                                                            (self.image_size[1],self.image_size[0]),
                                                            flags=cv2.INTER_LINEAR + cv2.WARP_INVERSE_MAP))
        else:
            self.aligned_images.append(cv2.warpAffine(image,
                                                 self.warp_matrix,
                                                 (self.image_size[1],self.image_size[0]),
                                                 flags=cv2.INTER_LINEAR + cv2.WARP_INVERSE_MAP))

    def mertens(self):
        # Returns a file descriptor
        merge_mertens = cv2.createMergeMertens()
        res_mertens = merge_mertens.process([self.images[0]]+self.aligned_images)
        final_image = np.clip(res_mertens*255, 0, 255).astype('uint8')
        cv2.imwrite(self.results_file_path, final_image)

