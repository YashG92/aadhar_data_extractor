<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aadhar Data Extractor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            padding: 20px;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }
        h1 {
            color: #4a90e2;
            text-align: center;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            background: #eaf4ff;
            margin: 10px 0;
            padding: 15px;
            border-left: 4px solid #4a90e2;
            border-radius: 5px;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            color: #888;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Aadhar Data Extractor</h1>
        <p>Extract key information (e.g., DOB) from Aadhar card images using Flutter and Google ML Kit. This app leverages text recognition to parse Aadhar card details and extract the date of birth (DOB) in <strong>DD/MM/YYYY</strong> format.</p>

        <h2>Features:</h2>
        <ul>
            <li><strong>Text Recognition:</strong> Uses Google ML Kit to recognize text from Aadhar card images.</li>
            <li><strong>DOB Extraction:</strong> Extracts the date of birth (DOB) in DD/MM/YYYY format.</li>
            <li><strong>Noise Handling:</strong> Cleans OCR output to handle noisy text recognition.</li>
            <li><strong>Validation:</strong> Validates extracted dates to ensure accuracy.</li>
            <li><strong>Cross-Platform:</strong> Works on both Android and iOS.</li>
        </ul>

        <div class="footer">
            &copy; 2025 Aadhar Data Extractor
        </div>
    </div>
</body>
</html>
