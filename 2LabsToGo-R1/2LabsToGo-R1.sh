#Script to update 2LabsToGo software Revision 1
#unpack 2LabsToGo-R1.7z to 2LabsToGo-Software folder

#case light off for camera position, case light on for homing; Image capture pop up window
yes | sudo mv ../app/templates/js/oclab/detection.js ../app/templates/js/oclab/detection.js.old
yes | sudo cp detection.js ../app/templates/js/oclab
yes | sudo mv ../app/detection/templates/capture.html ../app/detection/templates/capture.html.old
yes | sudo cp capture.html ../app/detection/templates
#humidity control
yes | sudo cp templates/humiditycontrol.html ../app/finecontrol/templates/humiditycontrol.html
yes | mkdir  ../app/templates/modules/humiditycontrol
yes | sudo cp modules/humiditycontrol.js modules/humiditycontrol.html ../app/templates/modules/humiditycontrol 
yes | sudo mv ../app/finecontrol/views.py ../app/finecontrol/views.py.old
yes | sudo mv ../app/finecontrol/urls.py ../app/finecontrol/urls.py.old
yes | sudo cp views.py urls.py ../app/finecontrol
yes | sudo mv ../app/templates/sidebar.html ../app/templates/sidebar.html.old
yes | sudo cp sidebar.html ../app/templates
#drypump
yes | sudo mv ../app/templates/modules/drypump/drypump.html ../app/templates/modules/drypump/drypump.html.old
yes | sudo cp drypump.html ../app/templates/modules/drypump  # switch 3-way valve to autosampler mode
#process image: simple white balance added
yes | sudo mv ../app/templates/modules/Image_Process/script.js ../app/templates/modules/Image_Process/script.js.old
yes | sudo cp image_process/script.js ../app/templates/modules/Image_Process
yes | sudo mv ../app/detection/views.py ../app/detection/views.py.old
yes | sudo mv ../app/detection/urls.py ../app/detection/urls.py.old
yes | sudo cp image_process/views.py image_process/urls.py ../app/detection
yes | sudo mv ../app/detection/templates/Image_Process.html ../app/detection/templates/Image_Process.html.old
yes | sudo cp image_process/Image_Process.html ../app/detection/templates




