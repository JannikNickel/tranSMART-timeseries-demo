#Requirements git, docker, docker-compose

DOMAIN="$1"
FULL_DATASET="$2"

#Clone docker based transmart
git clone https://gitlab.gwdg.de/medinfpub/tm_umg.git --branch master --single-branch
cd tm_umg
#Set head to the tested commit
git checkout b03a69a47a700207b5ff9b2745677754f664beed

#Setup transmart settings
cp .env_RENAME .env
sed -i "s/DOMAIN=CHANGE_ME/DOMAIN=$DOMAIN/g" .env

#Pull images
docker-compose pull

#Run for the first time
echo "> Starting instance (warmup)"
docker-compose up -d

#Wait about one minute for first startup
echo "> Waiting 90 seconds..."
sleep 90s

#Stop docker compose
docker-compose down

#Clear imported data
docker volume rm -f tm_umg_tm_postgresdata

#Replace transmart war with custom version
cd ../
sudo rm /var/lib/docker/volumes/tm_umg_tm_apptomcat/_data/webapps/transmart.war
sudo rm -R /var/lib/docker/volumes/tm_umg_tm_apptomcat/_data/webapps/transmart/
sudo cp res/transmart.war /var/lib/docker/volumes/tm_umg_tm_apptomcat/_data/webapps/

#Place MIMIC3 dataset into the input directory
if [ "$FULL_DATASET" == "FULL" ]
then
    sudo cp res/MIMIC3_DEMO.zip /var/lib/docker/volumes/tm_umg_tm_opt/_data/data/incoming/
else
    sudo cp res/MIMIC3_MIN.zip /var/lib/docker/volumes/tm_umg_tm_opt/_data/data/incoming/
fi

#Start transmart to start import of MIMIC-III dataset
cd tm_umg
docker-compose up -d && docker-compose logs -f
