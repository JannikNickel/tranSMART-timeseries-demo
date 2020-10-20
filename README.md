# BA tranSMART MIMIC-III demo

Install script for creating a docker based tranSMART installation on an ubuntu server. (tested with 18.04 LTS)
The docker setup is available at https://gitlab.gwdg.de/medinfpub/tm_umg and will be downloaded by the install script.

A custom tranSMART version with time series visualization is available in the releases of this repository and will be installed. A transformed version of the MIMIC-III dataset (https://doi.org/10.13026/C2HM2Q) will be loaded automatically.

## Requirements
The required programs of the install script will NOT be installed automatically. To install and run the tranSMART version you need the following applications installed on your machine:
* git
* docker (https://docs.docker.com/get-docker/)
* docker-compose (https://docs.docker.com/compose/install/)

## Running the script
1) Download the latest release, which includes all required resources (https://github.com/JannikNickel/BA_transmart_timeseries/releases)
2) Navigate into the repository directory
3) Run the install script: `./install.sh YOUR_SERVER_URL`
4) This will import a reduced MIMIC-III DEMO dataset with 4 time series variables. To import the full dataset use the command `./install.sh YOUR_SERVER_URL FULL`
The import of the reduced dataset takes 10-15 minutes. The import of the full dataset can take up to 24 hours or more depending on the server performance.

## Testing the visualization
1) Open your server URL in a browser
2) The default login data is admin/admin
3) Create a subset of your choice
4) In the SmartR category, you can find the workflow 'timeseries'
5) Drag and drop high dimensional variables in the workflow (Available under `Public Studies/MIMIC3_MIN/Subjects/Hospital Stays/Visit 01/Medical/Observations/`)
6) Click fetch data to collect the variables from the database
7) In the Run Analysis tab, you can visualize the variables
