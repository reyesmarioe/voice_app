import subprocess
from azure.storage.blob import BlobServiceClient

# Azure Blob Storage connection string
azure_connection_string = "DefaultEndpointsProtocol=https;AccountName=cs410032001eacab1d7;AccountKey=BGSQ3qn21WeD0mzUGCwZxA5mTbSHA+2Nyx+gCU8YY3p2kJtmuqytIhhHBRljt1NPKjmPynOlR32y+AStLcWPRQ==;EndpointSuffix=core.windows.net"

# Blob Container and .wav file name
container_name = "testcontainer"
blob_name = "audio.wav"

# Local file path for downloading the .wav file
local_file_path = "C:\\Users\\raydi\\OneDrive\\Documents\\audio.wav"

# Initialize the BlobServiceClient
blob_service_client = BlobServiceClient.from_connection_string(azure_connection_string)
container_client = blob_service_client.get_container_client(container_name)

# Download the .wav file from Azure Blob Storage
blob_client = container_client.get_blob_client(blob_name)
with open(local_file_path, "wb") as file:
    blob_data = blob_client.download_blob()
    file.write(blob_data.readall())

# Execute the Python script on the downloaded .wav file
python_script_path = "stt.py"
subprocess.run(["python", python_script_path, local_file_path])

# Perform any further processing or upload the result back to Azure Blob Storage if needed
