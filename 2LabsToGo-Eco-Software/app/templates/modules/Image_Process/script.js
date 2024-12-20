// Get references to the elements
const imageUpload = document.getElementById('image-upload');

const skip_top = document.getElementById('top-skip');
const skip_bottom = document.getElementById('bottom-skip');
const skip_apply = document.getElementById('apply-skip-button');

const redSlider_b = document.getElementById('red-slider-b');
const greenSlider_b = document.getElementById('green-slider-b');
const blueSlider_b = document.getElementById('blue-slider-b');

const redSlider_f = document.getElementById('red-slider-f');
const greenSlider_f = document.getElementById('green-slider-f');
const blueSlider_f = document.getElementById('blue-slider-f');

const redValue_b = document.getElementById('red-value-b');
const greenValue_b = document.getElementById('green-value-b');
const blueValue_b = document.getElementById('blue-value-b');

const redValue_f = document.getElementById('red-value-f');
const greenValue_f = document.getElementById('green-value-f');
const blueValue_f = document.getElementById('blue-value-f');

const red_threshold = document.getElementById('threshold-red');
const green_threshold = document.getElementById('threshold-green');
const blue_threshold = document.getElementById('threshold-blue');

const brightnessSlider = document.getElementById('brightness-slider');
const contrastSlider = document.getElementById('contrast-slider');
const hueSlider = document.getElementById('hue-slider');

const brightnessValue = document.getElementById('brightness-value');
const contrastValue = document.getElementById('contrast-value');
const hueValue = document.getElementById('hue-value');

let currentBrightness = 1;
let currentContrast = 1;
let currentHue = 0;

var uploadedImage = document.getElementById('uploaded-image');


let initialPixelData; 
let initialRedValue;
let initialGreenValue;
let initialBlueValue;

let isInitialRGBCalculated;
let isSlidersInteracted = false;
let other_source = false;
let isNavigating;

// Process the initial photo
document.addEventListener('DOMContentLoaded', function() {	
	Get_Initial_values(document.getElementById('uploaded-image'));
});

// Event listener for file upload
imageUpload.addEventListener('input', Image_Upload);

// Event listener for reset and apply button
skip_apply.addEventListener('click', function() {
	Reset();
	    setTimeout(() => {
			isInitialRGBCalculated = false;
			Get_Initial_values(document.getElementById('uploaded-image'));
    }, 100); // Adding a 100ms delay to ensure all elements are initialized
});

// Event listener for rgb value changes
document.addEventListener('DOMContentLoaded', (event) => {
    const updateImageColor = (type, r, g, b) => {
        switch(type) {
            case 'background':
                updateImageColor_b(r, g, b);
                break;
            case 'foreground':
                updateImageColor_f(r, g, b);
                break;
        }
    };

    const updateSliderAndColor = (type, color, value) => {
        isSlidersInteracted = true;
        switch(type) {
            case 'background':
                switch(color) {
                    case 'red':
                        redSlider_b.value = parseInt(value);
                        break;
                    case 'green':
                        greenSlider_b.value = parseInt(value);
                        break;
                    case 'blue':
                        blueSlider_b.value = parseInt(value);
                        break;
                }
                updateImageColor('background', redSlider_b.value, greenSlider_b.value, blueSlider_b.value);
                break;
            case 'foreground':
                switch(color) {
                    case 'red':
                        redSlider_f.value = parseInt(value);
                        break;
                    case 'green':
                        greenSlider_f.value = parseInt(value);
                        break;
                    case 'blue':
                        blueSlider_f.value = parseInt(value);
                        break;
                }
                updateImageColor('foreground', redSlider_f.value, greenSlider_f.value, blueSlider_f.value);
                break;
        }
    };

    const elements = [
        { id: 'red-value-b', type: 'background', color: 'red' },
        { id: 'green-value-b', type: 'background', color: 'green' },
        { id: 'blue-value-b', type: 'background', color: 'blue' },
        { id: 'red-value-f', type: 'foreground', color: 'red' },
        { id: 'green-value-f', type: 'foreground', color: 'green' },
        { id: 'blue-value-f', type: 'foreground', color: 'blue' },
        { id: 'red-slider-b', type: 'background', color: 'red' },
        { id: 'green-slider-b', type: 'background', color: 'green' },
        { id: 'blue-slider-b', type: 'background', color: 'blue' },
        { id: 'red-slider-f', type: 'foreground', color: 'red' },
        { id: 'green-slider-f', type: 'foreground', color: 'green' },
        { id: 'blue-slider-f', type: 'foreground', color: 'blue' }
    ];

    elements.forEach((element) => {
        const el = document.getElementById(element.id);
        el.addEventListener('input', () => {
            updateSliderAndColor(element.type, element.color, el.value);
        });
    });

    const filterElements = [
        { id: 'brightness-slider', property: 'brightness' },
        { id: 'contrast-slider', property: 'contrast' },
        { id: 'hue-slider', property: 'hue' },
        { id: 'brightness-value', property: 'brightness' },
        { id: 'contrast-value', property: 'contrast' },
        { id: 'hue-value', property: 'hue' },
    ];

    filterElements.forEach((element) => {
        const el = document.getElementById(element.id);
        el.addEventListener('input', () => {
			isSlidersInteracted = true;
            switch(element.property) {
                case 'brightness':
                    currentBrightness = el.value;
                    break;
                case 'contrast':
                    currentContrast = el.value;
                    break;
                case 'hue':
                    currentHue = el.value;
                    break;
            }
            Update_filter(currentBrightness, currentContrast, currentHue);
        });
    });
});

// Even Listener for right and left arrows 
document.getElementById( 'right' ).addEventListener('click', function() { 
	confirmSave();
	uploadedImage.src = originalImageSrc;
	isNavigating = false;
	navigate( 'next' );
});
document.getElementById( 'left' ).addEventListener('click', function() { 
	confirmSave();
	uploadedImage.src = originalImageSrc;
	isNavigating = false;
	navigate( 'pre' );
});


function Image_Upload( event ){
	ResetInitialSettings();
	isInitialRGBCalculated = false; 
	
	other_source = true;		
	document.getElementById( 'left' ).style.display = 'none';
	document.getElementById( 'right' ).style.display = 'none';
	const file = event.target.files[0];
	const reader = new FileReader();

	reader.onload = function(e) {
  
		uploadedImage.onload = function() {
			if ( !isInitialRGBCalculated ){
				Get_Initial_values( document.getElementById('uploaded-image') );
			}
		};

		uploadedImage.src = e.target.result;	
	};

	reader.readAsDataURL(file);
}


function Get_Initial_values( uploadedImage ){
	console.log("Entered Get_Initial_values")
	if (isInitialRGBCalculated){
		
		return;
		} 
	
	
	isInitialRGBCalculated = true;
	isSlidersInteracted = false;
	const{ canvas, context } = CreateCanvas();
	
	originalImageSrc = uploadedImage.src;
	
	photoName = Get_name( uploadedImage.src );
	
	document.getElementById("path").textContent = photoName;
	
	context.drawImage(uploadedImage, 0, 0);
	
	const pixelData = context.getImageData(0, 0, canvas.width, canvas.height).data;
	
	pixels_mean_RGB( pixelData );
	RGB_display_b( initialRedValue, initialGreenValue, initialBlueValue );
	Update_filter( 1, 1, 0 );
	BackGroundDetection( pixelData );
	Foreground_pixels_mean_RGB( pixelData );
	RGB_display_f( Foreground_initialRedValue, Foreground_initialGreenValue, Foreground_initialBlueValue );
	
	initialPixelData = new Uint8ClampedArray(pixelData); // Save a copy of the initial pixel data
}


function pixels_mean_RGB( pixelData ){
	let totalRed = 0;
	let totalGreen = 0;
	let totalBlue = 0;
	

	
	for (let i = 0; i < pixelData.length; i += 4) {
		const redValue = pixelData[i];
		const greenValue = pixelData[i + 1];
		const blueValue = pixelData[i + 2];

		totalRed += redValue;
		totalGreen += greenValue;
		totalBlue += blueValue;
	}

	const pixelCount = pixelData.length / 4; //since each pixel has 4 color components (RGBA)
	
	initialRedValue = Math.round(totalRed / pixelCount);
	initialGreenValue = Math.round(totalGreen / pixelCount);
	initialBlueValue = Math.round(totalBlue / pixelCount);
	
}

function BackGroundDetection( pixelData){
	
	const{canvas, context } = CreateCanvas();
	
	BackGround_index = []; 
	ForeGround_index = [];
	
	const top_rows = skip_top.value * canvas.height / 100;
	const bottom_rows = skip_bottom.value * canvas.height / 100;
	const start_index = Math.round(top_rows * canvas.width * 4);
	const end_index = Math.round(bottom_rows * canvas.width * 4);

	const RedThresholdValue = parseInt(red_threshold.value);
	const GreenThresholdValue = parseInt(green_threshold.value);
	const BlueThresholdValue = parseInt(blue_threshold.value);
	
	
	for (let i = 0; i <= start_index; i += 4) {
        BackGround_index.push(i);
    }
    
    for (let i = pixelData.length - end_index; i < pixelData.length; i += 4) {
        BackGround_index.push(i);
    }
	
	for (let i = start_index; i < pixelData.length - end_index; i += 4) {
		const redValue = pixelData[i];
		const greenValue = pixelData[i + 1];
		const blueValue = pixelData[i + 2];
		
		if ((redValue > (initialRedValue + RedThresholdValue)) || (greenValue > (initialGreenValue + GreenThresholdValue)) || (blueValue > (initialBlueValue + BlueThresholdValue))){
			ForeGround_index.push(i);
			
		}else{
			
			BackGround_index.push(i);
		}
		
	}

	
}

function Foreground_pixels_mean_RGB( pixelData ){
	let totalRed = 0;
	let totalGreen = 0;
	let totalBlue = 0;
	
	for (let i = 0; i < ForeGround_index.length; i += 4) {
		const redValue = pixelData[ForeGround_index[i]];
		const greenValue = pixelData[ForeGround_index[i] + 1];
		const blueValue = pixelData[ForeGround_index[i] + 2];

		totalRed += redValue;
		totalGreen += greenValue;
		totalBlue += blueValue;
	}

	const pixelCount = ForeGround_index.length / 4; //since each pixel has 4 color components (RGBA)
	
	Foreground_initialRedValue = Math.round(totalRed / pixelCount);
	Foreground_initialGreenValue = Math.round(totalGreen / pixelCount);
	Foreground_initialBlueValue = Math.round(totalBlue / pixelCount);
	
}
		
function navigate( direction ) {
		isNavigating = 0;
	    $.ajax({
		url: '/imageProcess/',
		type: 'POST',
		data: {
		    direction: direction,
		    current_photo_id: photoName
		},
		
		dataType: 'json',
		
		success: function( response ) {
		    console.log(response.imagepath)
		    $('#uploaded-image').attr('src', response.imagepath);
		    uploadedImage.onload = function(){
				if (isNavigating < 2){
					isInitialRGBCalculated = false;
					ResetInitialSettings();
					Get_Initial_values(document.getElementById('uploaded-image'));
					isNavigating = isNavigating + 1;
				}
				
			}
		},  
		error: function(xhr, status, error){
		    console.error(error);
		}
	    });
}



//~ function White_balance(){
	//~ const{canvas, context} = CreateCanvas();
	//~ const imageData = context.getImageData(0, 0, canvas.width, canvas.height);
	//~ const data = imageData.data;
	
	//~ let totalR = 0, totalG = 0, totalB = 0;
	//~ let pixelcount = 0;
	
	//~ for (let i = 0; i < data.length; i += 4) {
		//~ totalR += data[i];
		//~ totalG += data[i + 1];
		//~ totalB += data[i + 2];
		//~ pixelcount++;
	//~ }
	
	//~ const avgR = totalR / pixelcount;
	//~ const avgG = totalG / pixelcount;
	//~ const avgB = totalB / pixelcount;
	
	//~ const avgGray = (avgR + avgG + avgB) / 3;
	//~ const factorR = avgGray / avgR;
	//~ const factorG = avgGray / avgG;
	//~ const factorB = avgGray / avgB;
	
	//~ for (let i = 0; i < data.length; i +=4){
		//~ data[i] = Math.min(255, data[i] * factorR);
		//~ data[i + 1] = Math.min(255, data[i + 1] * factorG);
		//~ data[i + 2] = Math.min(255, data[i + 2] * factorB);
	//~ }
	
	//~ context.putImageData(imageData, 0, 0);
	//~ uploadedImage.src = canvas.toDataURL();
	
//~ }



//~ function White_balance(){
    //~ const initialRedValue = 128; // Example: Mid-point for 8-bit color depth
    //~ const initialGreenValue = 128;
    //~ const initialBlueValue = 128;
    
    //~ const redValue = parseInt(document.getElementById("redSlider").value, 10);
    //~ const greenValue = parseInt(document.getElementById("greenSlider").value, 10);
    //~ const blueValue = parseInt(document.getElementById("blueSlider").value, 10);
    //~ // Calculate differences for manual adjustment
    //~ const redDiff = redValue - initialRedValue;
    //~ const greenDiff = greenValue - initialGreenValue;
    //~ const blueDiff = blueValue - initialBlueValue;

    //~ // Process the image data to adjust RGB values
    //~ for (let i = 0; i < data.length; i += 4) {
        //~ data[i] = Math.min(Math.max(data[i] + redDiff, 0), 255); // Red
        //~ data[i + 1] = Math.min(Math.max(data[i + 1] + greenDiff, 0), 255); // Green
        //~ data[i + 2] = Math.min(Math.max(data[i + 2] + blueDiff, 0), 255); // Blue
    //~ }
//~ }




//~ function White_balance(){
	//~ console.log("Enterd white balance.")
	//~ const{ canvas, context } = CreateCanvas();
	//~ $('#uploaded-image').attr('src', canvas);
	//~ canvas.toBlob(function (blob) {
		//~ if (!blob){
			//~ alert('Failed to convert canvas to Blob.');
			//~ return;
		//~ }
		
	//~ const formData = new FormData();
	//~ formData.append('image', blob, 'canvas-image.png');

	//~ $.ajax({
		//~ url: '/imageProcess/whitebalance/',
		//~ type: 'POST',
		//~ data: formData,
		//~ contentType: false,
		//~ processData: false,
		//~ success: function (data, status, xhr) {
			//~ console.log("succesfully got image.")
			//~ const blob = new Blob([data], { type: xhr.getResponseHeader('Content-Type')});
			//~ const imageUrl = URL.createObjectURL(blob);
			//~ console.log(imageUrl)
			
			//~ $('#uploaded-image').attr('src', imageUrl);
			//~ Get_Initial_values(document.getElementById('uploaded-image'));
			
		//~ },
		//~ error: function (xhr, status, error){
			//~ alert(`Error: ${xhr.responseText || error}`);
		//~ },
		//~ xhr: function() {
			//~ const xhr = new XMLHttpRequest();
			//~ xhr.responseType = 'attaybuffer';
			//~ return xhr;
		//~ }
	//~ });
	//~ }, 'image/png');
//~ }


function White_balance() {
    console.log("Entered white balance.");

    const { canvas, context } = CreateCanvas();
    canvas.toBlob(function (blob) {
        if (!blob) {
            alert('Failed to convert canvas to Blob.');
            return;
        }

        const formData = new FormData();
        formData.append('image', blob, 'canvas-image.png');

        $.ajax({
            url: 'http://127.0.0.1:8000/imageProcess/whitebalance/',
            type: 'POST',
            data: formData, // Use FormData for binary data
            contentType: false, // Let the browser set the Content-Type
            processData: false, // Don't process FormData
            success: function (data, status, xhr) {
                const contentType = xhr.getResponseHeader('Content-Type');
                if (contentType && contentType.startsWith('image/')) {
                    // Convert the binary response to a Blob and create an image URL
                    const blob = new Blob([data], { type: contentType });
                    const imageUrl = URL.createObjectURL(blob);

                    // Display the processed image in the HTML <img> element
                    $('#uploaded-image').attr('src', imageUrl);
                } else {
                    alert('Unexpected response from server.');
                }
            },
            error: function (xhr, status, error) {
                alert(`Error: ${xhr.responseText || error}`);
            },
            xhr: function () {
                const xhr = new XMLHttpRequest();
                xhr.responseType = 'arraybuffer'; // Ensure binary response
                return xhr;
            }
        });
    }, 'image/png');
}








function Get_name( src ){
	if (other_source){
		
		var fileInput = document.getElementById('image-upload');
		return fileInput.files[0].name;
		
		if (fileInput.files.length > 0) {
			
			return fileInput.files[0].name;
			
		} else {
			
			return null;
			
		}
		
	}else{
		
		var parts = src.split('/');
		var photoName = parts[parts.length - 1];
		document.getElementById("path").innerHTML = photoName;
		return photoName;
		
	}
}

function confirmSave(){
	
	if (isSlidersInteracted){
		
		var result = confirm("Do you want to save the changes?");
		
		if (result){
			
			SaveData();
			
		}
	}
}

function SaveData(){
	
	const{ canvas, context } = CreateCanvas();
	
	canvas.toBlob(function (blob) {
		
		// Create a temporary URL for the Blob
		var url = URL.createObjectURL(blob);

		// Create a custom file name
		var lastdotIndex = photoName.lastIndexOf('.');
		var customFileName = photoName ? photoName.substring(0, lastdotIndex) : "modified_image"; 
		customFileName += '_RGB_' + redSlider_b.value + '_' + greenSlider_b.value + '_' + blueSlider_b.value + '.jpeg';
		var a = document.createElement('a');
		a.href = url;
		a.download = customFileName; // Set the default file name
		document.body.appendChild(a);

		a.click();

		// Clean up
		document.body.removeChild(a);
		URL.revokeObjectURL(url); 
	}, 'image/jpeg');
}

function DataBase() {
	var isDatabase = false;
	confirmSave();
	other_source = false; 
	document.getElementById('left').style.display = '';
	document.getElementById('right').style.display = '';
	 $.ajax({
		url: '/imageProcess/',
		type: 'POST',
		data: {
		    direction: '',
		    current_photo_id: ''
		},
		dataType: 'json',
		success: function(response) {
		    $('#uploaded-image').attr('src', response.imagepath);
		    
		    uploadedImage.onload = function(){
				if (isDatabase) return;
				isInitialRGBCalculated = false;
				ResetInitialSettings();
				Get_Initial_values(document.getElementById('uploaded-image'));
				isDatabase = true;
			}
		},  
		error: function(xhr, status, error){
		    console.error(error);
		}
	    });
}

function Default( mode ){
	isSlidersInteracted = true;
	if (mode == "light"){
		
		Update_filter(0.8, 2, 0);
		updateImageColor_b(230, 230, 230);
		
	}else if (mode == "dark"){
		
		Update_filter(2, 1.5, 0);
		updateImageColor_b(0, 0, 0);
	}
}

function Reset(){
	
	isSlidersInteracted = false;
	uploadedImage.src = originalImageSrc;
	RGB_display_b(initialRedValue, initialGreenValue, initialBlueValue);
	RGB_display_f(Foreground_initialRedValue, Foreground_initialGreenValue, Foreground_initialBlueValue);	
	Update_filter(1, 1, 0);
}

function updateImageColor_b( redValue, greenValue, blueValue ) {
	
	if (!isSlidersInteracted) return; // Ignore first change
	RGB_display_b(redValue, greenValue, blueValue);
	const{ canvas, context } = CreateCanvas();
	context.drawImage(uploadedImage, 0, 0);
	const imageData = context.getImageData(0, 0, canvas.width, canvas.height);
	const data = imageData.data;
	
	const redDiff = redValue - initialRedValue;
	const greenDiff = greenValue - initialGreenValue;
	const blueDiff = blueValue - initialBlueValue;
	
	for (let i = 0; i < BackGround_index.length; i++) {
		data[BackGround_index[i]] = initialPixelData[BackGround_index[i]] + redDiff;
		data[BackGround_index[i] + 1] = initialPixelData[BackGround_index[i] + 1] + greenDiff;
		data[BackGround_index[i] + 2] = initialPixelData[BackGround_index[i] + 2] + blueDiff;
	}

	context.putImageData(imageData, 0, 0);
	uploadedImage.src = canvas.toDataURL(); 
}

function updateImageColor_f( redValue, greenValue, blueValue ) {
	
	if (!isSlidersInteracted) return; // Ignore first change
	RGB_display_f(redValue, greenValue, blueValue);
	const{ canvas, context } = CreateCanvas();
	context.drawImage(uploadedImage, 0, 0);
	const imageData = context.getImageData(0, 0, canvas.width, canvas.height);
	const data = imageData.data;

	const redDiff = redValue - initialRedValue;
	const greenDiff = greenValue - initialGreenValue;
	const blueDiff = blueValue - initialBlueValue;
	
	for (let i = 0; i < ForeGround_index.length; i++) {
		data[ForeGround_index[i]] = initialPixelData[ForeGround_index[i]] + redDiff;
		data[ForeGround_index[i] + 1] = initialPixelData[ForeGround_index[i] + 1] + greenDiff;
		data[ForeGround_index[i] + 2] = initialPixelData[ForeGround_index[i] + 2] + blueDiff;
	}

	context.putImageData(imageData, 0, 0);
	uploadedImage.src = canvas.toDataURL(); 
}
	 
function Update_filter( brightnessInput, contrastInput, hueInput ){
	
	currentBrightness = brightnessInput;
	currentContrast = contrastInput;
	currentHue = hueInput;
	
	const filterValue = `brightness(${brightnessInput}) contrast(${contrastInput}) hue-rotate(${hueInput}deg)`;
	uploadedImage.style.filter = filterValue;
	
	brightnessSlider.value = brightnessInput;
	contrastSlider.value = contrastInput;
	hueSlider.value = hueInput;
	
	brightnessValue.value = brightnessInput;
	contrastValue.value = contrastInput;
	hueValue.value = hueInput;
}
  
function RGB_display_b( red, green, blue ){
	 
	redSlider_b.value = red;
	greenSlider_b.value = green;
	blueSlider_b.value = blue;
	
	redValue_b.value = red;
	greenValue_b.value = green;
	blueValue_b.value = blue;
	
	document.getElementById("RGB-b").innerHTML = "RGB( " + red + ' , ' + green + ' , ' + blue + ' )';
	document.getElementById("InitialRGB").innerHTML = "Initial RGB( " + initialRedValue + ' , ' + initialGreenValue + ' , ' + initialBlueValue + ' )';

}

function RGB_display_f( red, green, blue ){
	 
	redSlider_f.value = red;
	greenSlider_f.value = green;
	blueSlider_f.value = blue;
	
	redValue_f.value = red;
	greenValue_f.value = green;
	blueValue_f.value = blue;
	
	document.getElementById("RGB-f").innerHTML = "RGB( " + red + ' , ' + green + ' , ' + blue + ' )';
	document.getElementById("InitialRGB").innerHTML = "Initial RGB( " + initialRedValue + ' , ' + initialGreenValue + ' , ' + initialBlueValue + ' )';

}

function ResetInitialSettings(){
	
	skip_top.value = 0;
	skip_bottom.value = 0;
	
	red_threshold.value = 20;
	green_threshold.value = 15;
	blue_threshold.value = 18;
	
}
 
function CreateCanvas(){
	const canvas = document.createElement('canvas');
	const context = canvas.getContext('2d', { willReadFrequently: true });
	canvas.width = uploadedImage.naturalWidth;
	canvas.height = uploadedImage.naturalHeight;
	context.filter = `brightness(${currentBrightness}) contrast(${currentContrast}) hue-rotate(${currentHue}deg)`;
	context.drawImage(uploadedImage, 0, 0);
	return { canvas, context };
}
