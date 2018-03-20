

```python
#Observations

#1.Cities located between the -20 and 20 degrees latitude band have the highest temperatures. Temperatures decrease as cities 
#  move away from this band on either side. 

#2.Cloudiness and humidity are evenly distributed across the latitude. Majority of the cities have greater than 
# 50% of the humidity.

#4.About 80% of the cities have wind speeds below 20 mph, and there is no clear trend between wind speed and latitude.
```


```python
import csv
import json
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import requests
import openweathermapy.core as owm
from citipy import citipy
from datetime import datetime
import time
```


```python
owmkey = "f23de46e6c0b3500090a3e67a71e4eb2"
base_url = "http://api.openweathermap.org/data/2.5/weather?"
settings =  {"units": "imperial", "APPID": owmkey}
```


```python
cities = []
name = []
country = []
 
lat = np.random.uniform(low=-90, high=90, size=600)
lon = np.random.uniform(low=-180, high=180, size=600)

for lat,lon in zip(lat,lon):
    cities.append(citipy.nearest_city(lat,lon))

for city in cities:   
    name.append(city.city_name)
    country.append(city.country_code)
 
#locations = list(zip(name,country))

weather_dict = {"City": name, "Country": country} 
weather_pd = pd.DataFrame(weather_dict)
```


```python
weather_data = []
data = []
units = "Imperial"

for index, row in weather_pd.iterrows(): 
    try:
        location = f'{row["City"]},{row["Country"]}'
        query_url = f"{base_url}appid={owmkey}&units={units}&q={location}"
        weather_data = owm.get_current(location, **settings)
        print(f"Processing {location}")
        print(query_url)
        views = {"summary": ["name","sys.country","clouds.all","dt","main.humidity","coord.lat","coord.lon","main.temp_max",
                             "wind.speed"]}
        
        data.append(weather_data.get_dict(views["summary"]))
    except Exception:
        #print(f'{row['City']},{row['Country']}not found')
     #   print ("  exception  ")
        pass
        
weather_data_pd = pd.DataFrame(data)

weather_data_pd.head()

weather_data_pd = weather_data_pd.rename(columns={"name":"City","clouds.all":"Cloudiness","sys.country":"Country",
                                               "dt":"Date","main.humidity":"Humidity","coord.lat":"Lat","coord.lon":"Lng",
                                               "main.temp_max":"Max Temp","wind.speed":"Wind Speed"})



weather_data_pd = weather_data_pd[["City","Cloudiness","Country","Date","Humidity","Lat","Lng","Max Temp","Wind Speed"]]  

#weather_data_pdhvs = weather_data_pd[['City']]  

weather_data_pd.to_csv("CityWeatherData.csv", index=False)
weather_data_pd.to_json("CityWeatherData.json")
weather_data_pd.head()
```

    Processing lahat,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lahat,id
    Processing sao joao da barra,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=sao joao da barra,br
    Processing kapaa,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kapaa,us
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing dayong,cn
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=dayong,cn
    Processing medea,dz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=medea,dz
    Processing winslow,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=winslow,us
    Processing angoche,mz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=angoche,mz
    Processing port alfred,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port alfred,za
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing severo-kurilsk,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=severo-kurilsk,ru
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing hobart,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hobart,au
    Processing kodiak,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kodiak,us
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing vaini,to
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vaini,to
    Processing hofn,is
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hofn,is
    Processing chicama,pe
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=chicama,pe
    Processing ahipara,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ahipara,nz
    Processing pontes e lacerda,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=pontes e lacerda,br
    Processing bluff,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bluff,nz
    Processing hermanus,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hermanus,za
    Processing halmstad,se
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=halmstad,se
    Processing saint-francois,gp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=saint-francois,gp
    Processing bluff,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bluff,nz
    Processing albany,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=albany,au
    Processing srednekolymsk,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=srednekolymsk,ru
    Processing alice springs,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=alice springs,au
    Processing rocha,uy
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rocha,uy
    Processing cape town,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cape town,za
    Processing teahupoo,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=teahupoo,pf
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing nome,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=nome,us
    Processing luanda,ao
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=luanda,ao
    Processing qaanaaq,gl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=qaanaaq,gl
    Processing severo-kurilsk,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=severo-kurilsk,ru
    Processing tuatapere,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tuatapere,nz
    Processing janauba,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=janauba,br
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing mareeba,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mareeba,au
    Processing yellowknife,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yellowknife,ca
    Processing saskylakh,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=saskylakh,ru
    Processing avarua,ck
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=avarua,ck
    Processing ishinomaki,jp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ishinomaki,jp
    Processing cape town,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cape town,za
    Processing qasigiannguit,gl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=qasigiannguit,gl
    Processing cotonou,bj
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cotonou,bj
    Processing lieksa,fi
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lieksa,fi
    Processing new norfolk,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=new norfolk,au
    Processing kununurra,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kununurra,au
    Processing new norfolk,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=new norfolk,au
    Processing tiksi,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tiksi,ru
    Processing mazamari,pe
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mazamari,pe
    Processing ilulissat,gl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ilulissat,gl
    Processing westport,ie
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=westport,ie
    Processing ratesti,ro
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ratesti,ro
    Processing san cristobal,ec
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=san cristobal,ec
    Processing castro,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=castro,cl
    Processing vila franca do campo,pt
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vila franca do campo,pt
    Processing khatanga,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=khatanga,ru
    Processing carnarvon,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=carnarvon,au
    Processing tabuk,sa
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tabuk,sa
    Processing mar del plata,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mar del plata,ar
    Processing mapiripan,co
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mapiripan,co
    Processing puerto ayora,ec
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=puerto ayora,ec
    Processing mahebourg,mu
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mahebourg,mu
    Processing dikson,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=dikson,ru
    Processing dingle,ie
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=dingle,ie
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing cape town,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cape town,za
    Processing puerto ayora,ec
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=puerto ayora,ec
    Processing butaritari,ki
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=butaritari,ki
    Processing gizo,sb
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=gizo,sb
    Processing hobart,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hobart,au
    Processing cherskiy,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cherskiy,ru
    Processing pipri,in
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=pipri,in
    Processing palmer,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=palmer,us
    Processing coihaique,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=coihaique,cl
    Processing hirara,jp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hirara,jp
    Processing mezen,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mezen,ru
    Processing murgab,tm
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=murgab,tm
    Processing oxford,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=oxford,ca
    Processing esperance,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=esperance,au
    Processing albany,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=albany,au
    Processing kapaa,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kapaa,us
    Processing tamasi,ro
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tamasi,ro
    Processing talnakh,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=talnakh,ru
    Processing vao,nc
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vao,nc
    Processing hobart,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hobart,au
    Processing new norfolk,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=new norfolk,au
    Processing busselton,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=busselton,au
    Processing omboue,ga
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=omboue,ga
    Processing itarema,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=itarema,br
    Processing puerto ayora,ec
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=puerto ayora,ec
    Processing nago,jp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=nago,jp
    Processing yellowknife,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yellowknife,ca
    Processing albany,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=albany,au
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing salalah,om
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=salalah,om
    Processing katsuura,jp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=katsuura,jp
    Processing victoria,sc
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=victoria,sc
    Processing smithers,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=smithers,ca
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing yellowknife,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yellowknife,ca
    Processing coquimbo,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=coquimbo,cl
    Processing ostrovnoy,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ostrovnoy,ru
    Processing aswan,eg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=aswan,eg
    Processing presidencia roque saenz pena,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=presidencia roque saenz pena,ar
    Processing san vicente,ph
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=san vicente,ph
    Processing hithadhoo,mv
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hithadhoo,mv
    Processing kristiansund,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kristiansund,no
    Processing bluff,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bluff,nz
    Processing kysyl-syr,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kysyl-syr,ru
    Processing bluff,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bluff,nz
    Processing pombia,gr
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=pombia,gr
    Processing galle,lk
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=galle,lk
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing yellowknife,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yellowknife,ca
    Processing cape town,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cape town,za
    Processing bluff,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bluff,nz
    Processing castro,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=castro,cl
    Processing yantal,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yantal,ru
    Processing tolaga bay,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tolaga bay,nz
    Processing turukhansk,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=turukhansk,ru
    Processing monkey bay,mw
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=monkey bay,mw
    Processing port alfred,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port alfred,za
    Processing barrow,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=barrow,us
    Processing bredasdorp,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bredasdorp,za
    Processing comodoro rivadavia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=comodoro rivadavia,ar
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing souillac,mu
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=souillac,mu
    Processing meulaboh,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=meulaboh,id
    Processing altamont,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=altamont,us
    Processing jiangyou,cn
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=jiangyou,cn
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing hermanus,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hermanus,za
    Processing hasaki,jp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hasaki,jp
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing saskylakh,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=saskylakh,ru
    Processing puerto ayora,ec
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=puerto ayora,ec
    Processing kapaa,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kapaa,us
    Processing torbay,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=torbay,ca
    Processing torbay,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=torbay,ca
    Processing new norfolk,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=new norfolk,au
    Processing bangangte,cm
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bangangte,cm
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing kodiak,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kodiak,us
    Processing jamestown,sh
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=jamestown,sh
    Processing jamestown,sh
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=jamestown,sh
    Processing lyngseidet,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lyngseidet,no
    Processing port alfred,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port alfred,za
    Processing xai-xai,mz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=xai-xai,mz
    Processing bluff,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bluff,nz
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing georgetown,sh
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=georgetown,sh
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing ust-barguzin,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ust-barguzin,ru
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing igarka,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=igarka,ru
    Processing hithadhoo,mv
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hithadhoo,mv
    Processing port alfred,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port alfred,za
    Processing chokurdakh,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=chokurdakh,ru
    Processing kavieng,pg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kavieng,pg
    Processing northam,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=northam,au
    Processing yellowknife,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yellowknife,ca
    Processing tessalit,ml
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tessalit,ml
    Processing vaini,to
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vaini,to
    Processing litovko,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=litovko,ru
    Processing sanmenxia,cn
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=sanmenxia,cn
    Processing nuevo laredo,mx
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=nuevo laredo,mx
    Processing sao filipe,cv
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=sao filipe,cv
    Processing kupang,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kupang,id
    Processing alyangula,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=alyangula,au
    Processing deer lake,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=deer lake,ca
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing carnarvon,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=carnarvon,au
    Processing port alfred,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port alfred,za
    Processing amga,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=amga,ru
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing qaanaaq,gl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=qaanaaq,gl
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing tiznit,ma
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tiznit,ma
    Processing ahvaz,ir
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ahvaz,ir
    Processing rafsanjan,ir
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rafsanjan,ir
    Processing longyearbyen,sj
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=longyearbyen,sj
    Processing hofn,is
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hofn,is
    Processing kruisfontein,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kruisfontein,za
    Processing cidreira,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cidreira,br
    Processing bluff,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bluff,nz
    Processing hilo,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hilo,us
    Processing mercedes,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mercedes,ar
    Processing zuenoula,ci
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=zuenoula,ci
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing mao,td
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mao,td
    Processing lorengau,pg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lorengau,pg
    Processing cuautepec,mx
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cuautepec,mx
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing kamenka,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kamenka,ru
    Processing raudeberg,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=raudeberg,no
    Processing jamestown,sh
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=jamestown,sh
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing suwa,jp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=suwa,jp
    Processing vaini,to
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vaini,to
    Processing hilo,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hilo,us
    Processing hermanus,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hermanus,za
    Processing vaini,to
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vaini,to
    Processing puerto ayora,ec
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=puerto ayora,ec
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing santa isabel do rio negro,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=santa isabel do rio negro,br
    Processing saldanha,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=saldanha,za
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing morondava,mg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=morondava,mg
    Processing anadyr,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=anadyr,ru
    Processing poronaysk,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=poronaysk,ru
    Processing port-cartier,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port-cartier,ca
    Processing khatanga,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=khatanga,ru
    Processing arlit,ne
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=arlit,ne
    Processing ilulissat,gl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ilulissat,gl
    Processing jamestown,sh
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=jamestown,sh
    Processing avarua,ck
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=avarua,ck
    Processing hilo,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hilo,us
    Processing vardo,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vardo,no
    Processing pierre,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=pierre,us
    Processing berlevag,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=berlevag,no
    Processing cape town,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cape town,za
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing konevo,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=konevo,ru
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing kupang,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kupang,id
    Processing hilo,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hilo,us
    Processing port hedland,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port hedland,au
    Processing chapais,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=chapais,ca
    Processing tonkino,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tonkino,ru
    Processing yellowknife,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yellowknife,ca
    Processing lorengau,pg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lorengau,pg
    Processing nantucket,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=nantucket,us
    Processing rabo de peixe,pt
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rabo de peixe,pt
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing puerto maldonado,pe
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=puerto maldonado,pe
    Processing bredasdorp,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bredasdorp,za
    Processing saskylakh,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=saskylakh,ru
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing butaritari,ki
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=butaritari,ki
    Processing qaanaaq,gl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=qaanaaq,gl
    Processing kahului,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kahului,us
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing aygezard,am
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=aygezard,am
    Processing hermanus,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hermanus,za
    Processing ponta do sol,cv
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ponta do sol,cv
    Processing dikson,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=dikson,ru
    Processing tuktoyaktuk,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tuktoyaktuk,ca
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing nanortalik,gl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=nanortalik,gl
    Processing mahebourg,mu
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mahebourg,mu
    Processing coquimbo,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=coquimbo,cl
    Processing kattivakkam,in
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kattivakkam,in
    Processing nikolskoye,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=nikolskoye,ru
    Processing san patricio,mx
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=san patricio,mx
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing ponta do sol,pt
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ponta do sol,pt
    Processing qaanaaq,gl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=qaanaaq,gl
    Processing yellowknife,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yellowknife,ca
    Processing hermanus,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hermanus,za
    Processing victoria,sc
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=victoria,sc
    Processing puerto ayora,ec
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=puerto ayora,ec
    Processing lagoa,pt
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lagoa,pt
    Processing kimbe,pg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kimbe,pg
    Processing busselton,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=busselton,au
    Processing sungaipenuh,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=sungaipenuh,id
    Processing albany,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=albany,au
    Processing sangar,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=sangar,ru
    Processing busselton,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=busselton,au
    Processing hobart,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hobart,au
    Processing carnarvon,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=carnarvon,au
    Processing puerto ayora,ec
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=puerto ayora,ec
    Processing atambua,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atambua,id
    Processing castro,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=castro,cl
    Processing kapaa,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kapaa,us
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing sambava,mg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=sambava,mg
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing victoria,sc
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=victoria,sc
    Processing loding,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=loding,no
    Processing east london,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=east london,za
    Processing puerto ayora,ec
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=puerto ayora,ec
    Processing new norfolk,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=new norfolk,au
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing bluff,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bluff,nz
    Processing komsomolskiy,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=komsomolskiy,ru
    Processing khatanga,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=khatanga,ru
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing buraydah,sa
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=buraydah,sa
    Processing grindavik,is
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=grindavik,is
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing ostrovnoy,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ostrovnoy,ru
    Processing albany,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=albany,au
    Processing puerto leguizamo,co
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=puerto leguizamo,co
    Processing hithadhoo,mv
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hithadhoo,mv
    Processing busselton,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=busselton,au
    Processing paulista,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=paulista,br
    Processing singapore,sg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=singapore,sg
    Processing winkler,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=winkler,ca
    Processing iqaluit,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=iqaluit,ca
    Processing harper,lr
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=harper,lr
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing saint-philippe,re
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=saint-philippe,re
    Processing namibe,ao
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=namibe,ao
    Processing ambilobe,mg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ambilobe,mg
    Processing lagoa,pt
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lagoa,pt
    Processing hilo,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hilo,us
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing port alfred,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port alfred,za
    Processing cidreira,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cidreira,br
    Processing jamestown,sh
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=jamestown,sh
    Processing tonala,mx
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tonala,mx
    Processing albany,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=albany,au
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing ambon,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ambon,id
    Processing busselton,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=busselton,au
    Processing itoman,jp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=itoman,jp
    Processing cape town,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cape town,za
    Processing port lincoln,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port lincoln,au
    Processing hamilton,bm
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hamilton,bm
    Processing agadez,ne
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=agadez,ne
    Processing sumenep,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=sumenep,id
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing kapaa,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kapaa,us
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing arraial do cabo,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=arraial do cabo,br
    Processing qaanaaq,gl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=qaanaaq,gl
    Processing leningradskiy,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=leningradskiy,ru
    Processing roald,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=roald,no
    Processing lima,pe
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lima,pe
    Processing yellowknife,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yellowknife,ca
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing aitape,pg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=aitape,pg
    Processing barrow,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=barrow,us
    Processing bluff,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bluff,nz
    Processing yelatma,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yelatma,ru
    Processing longyearbyen,sj
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=longyearbyen,sj
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing hobart,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hobart,au
    Processing coihaique,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=coihaique,cl
    Processing warmbad,na
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=warmbad,na
    Processing margate,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=margate,za
    Processing lebu,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lebu,cl
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing lagoa,pt
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lagoa,pt
    Processing portland,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=portland,au
    Processing meulaboh,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=meulaboh,id
    Processing rundu,na
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rundu,na
    Processing aswan,eg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=aswan,eg
    Processing hermanus,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hermanus,za
    Processing salalah,om
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=salalah,om
    Processing san cristobal,ec
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=san cristobal,ec
    Processing east london,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=east london,za
    Processing labytnangi,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=labytnangi,ru
    Processing dikson,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=dikson,ru
    Processing rudbar,af
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rudbar,af
    Processing marsh harbour,bs
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=marsh harbour,bs
    Processing tual,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tual,id
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing lagoa,pt
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lagoa,pt
    Processing taoudenni,ml
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=taoudenni,ml
    Processing grand-santi,gf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=grand-santi,gf
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing arraial do cabo,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=arraial do cabo,br
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing arlit,ne
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=arlit,ne
    Processing new norfolk,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=new norfolk,au
    Processing thompson,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=thompson,ca
    Processing havre-saint-pierre,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=havre-saint-pierre,ca
    Processing bambous virieux,mu
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bambous virieux,mu
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing albany,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=albany,au
    Processing gorontalo,id
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=gorontalo,id
    Processing iqaluit,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=iqaluit,ca
    Processing mahebourg,mu
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mahebourg,mu
    Processing kaitangata,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kaitangata,nz
    Processing vestmannaeyjar,is
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vestmannaeyjar,is
    Processing hasaki,jp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hasaki,jp
    Processing chokwe,mz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=chokwe,mz
    Processing hermanus,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hermanus,za
    Processing tuktoyaktuk,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tuktoyaktuk,ca
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing margate,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=margate,za
    Processing santiago de cao,pe
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=santiago de cao,pe
    Processing beringovskiy,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=beringovskiy,ru
    Processing natchez,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=natchez,us
    Processing thompson,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=thompson,ca
    Processing bemidji,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bemidji,us
    Processing carnarvon,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=carnarvon,au
    Processing albany,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=albany,au
    Processing zhoucheng,cn
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=zhoucheng,cn
    Processing naze,jp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=naze,jp
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing new norfolk,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=new norfolk,au
    Processing kandrian,pg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=kandrian,pg
    Processing visnes,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=visnes,no
    Processing bethel,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bethel,us
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing vung tau,vn
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vung tau,vn
    Processing peleduy,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=peleduy,ru
    Processing albany,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=albany,au
    Processing mar del plata,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mar del plata,ar
    Processing vaini,to
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vaini,to
    Processing mar del plata,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mar del plata,ar
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing talnakh,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=talnakh,ru
    Processing narsaq,gl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=narsaq,gl
    Processing high level,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=high level,ca
    Processing jamestown,sh
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=jamestown,sh
    Processing ekhabi,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ekhabi,ru
    Processing fort frances,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=fort frances,ca
    Processing hermanus,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hermanus,za
    Processing tiksi,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tiksi,ru
    Processing atar,mr
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atar,mr
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing mount gambier,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mount gambier,au
    Processing mackay,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mackay,au
    Processing port shepstone,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port shepstone,za
    Processing jamestown,sh
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=jamestown,sh
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing arraial do cabo,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=arraial do cabo,br
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing torbay,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=torbay,ca
    Processing albany,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=albany,au
    Processing ancud,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ancud,cl
    Processing bardiyah,ly
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bardiyah,ly
    Processing najran,sa
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=najran,sa
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing cape town,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cape town,za
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing inirida,co
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=inirida,co
    Processing synya,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=synya,ru
    Processing adrar,dz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=adrar,dz
    Processing busselton,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=busselton,au
    Processing leh,in
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=leh,in
    Processing ouegoa,nc
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ouegoa,nc
    Processing clyde river,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=clyde river,ca
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing andros town,bs
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=andros town,bs
    Processing vaini,to
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vaini,to
    Processing te anau,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=te anau,nz
    Processing barrow,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=barrow,us
    Processing nome,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=nome,us
    Processing cape town,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=cape town,za
    Processing busselton,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=busselton,au
    Processing hobyo,so
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hobyo,so
    Processing hithadhoo,mv
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hithadhoo,mv
    Processing panambi,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=panambi,br
    Processing dicabisagan,ph
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=dicabisagan,ph
    Processing sibiti,cg
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=sibiti,cg
    Processing pierre,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=pierre,us
    Processing hobart,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hobart,au
    Processing maryville,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=maryville,us
    Processing hami,cn
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hami,cn
    Processing punta arenas,cl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=punta arenas,cl
    Processing lubango,ao
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lubango,ao
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing tromso,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tromso,no
    Processing springbok,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=springbok,za
    Processing sao filipe,cv
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=sao filipe,cv
    Processing melo,uy
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=melo,uy
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing aklavik,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=aklavik,ca
    Processing hilo,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hilo,us
    Processing rikitea,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rikitea,pf
    Processing amapa,br
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=amapa,br
    Processing takaka,nz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=takaka,nz
    Processing swan river,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=swan river,ca
    Processing dikson,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=dikson,ru
    Processing marquette,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=marquette,us
    Processing tekeli,kz
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tekeli,kz
    Processing hobart,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hobart,au
    Processing yerbogachen,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yerbogachen,ru
    Processing georgetown,sh
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=georgetown,sh
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing saint-francois,gp
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=saint-francois,gp
    Processing ushuaia,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=ushuaia,ar
    Processing sorland,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=sorland,no
    Processing vardo,no
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=vardo,no
    Processing port alfred,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port alfred,za
    Processing north platte,us
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=north platte,us
    Processing pevek,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=pevek,ru
    Processing yellowknife,ca
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=yellowknife,ca
    Processing atuona,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=atuona,pf
    Processing chuy,uy
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=chuy,uy
    Processing hermanus,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hermanus,za
    Processing bambous virieux,mu
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bambous virieux,mu
    Processing hermanus,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hermanus,za
    Processing port hedland,au
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=port hedland,au
    Processing talnakh,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=talnakh,ru
    Processing hithadhoo,mv
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=hithadhoo,mv
    Processing jamestown,sh
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=jamestown,sh
    Processing nikolskoye,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=nikolskoye,ru
    Processing akdepe,tm
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=akdepe,tm
    Processing butaritari,ki
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=butaritari,ki
    Processing riyadh,sa
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=riyadh,sa
    Processing bredasdorp,za
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=bredasdorp,za
    Processing faanui,pf
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=faanui,pf
    Processing butaritari,ki
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=butaritari,ki
    Processing tilichiki,ru
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=tilichiki,ru
    Processing lappeenranta,fi
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=lappeenranta,fi
    Processing rundu,na
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=rundu,na
    Processing augustow,pl
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=augustow,pl
    Processing mar del plata,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=mar del plata,ar
    Processing la rioja,ar
    http://api.openweathermap.org/data/2.5/weather?appid=f23de46e6c0b3500090a3e67a71e4eb2&units=Imperial&q=la rioja,ar
    




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>City</th>
      <th>Cloudiness</th>
      <th>Country</th>
      <th>Date</th>
      <th>Humidity</th>
      <th>Lat</th>
      <th>Lng</th>
      <th>Max Temp</th>
      <th>Wind Speed</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Lahat</td>
      <td>64</td>
      <td>ID</td>
      <td>1521505958</td>
      <td>98</td>
      <td>-3.78</td>
      <td>103.55</td>
      <td>72.35</td>
      <td>2.73</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Sao Joao da Barra</td>
      <td>0</td>
      <td>BR</td>
      <td>1521500400</td>
      <td>78</td>
      <td>-21.64</td>
      <td>-41.05</td>
      <td>78.80</td>
      <td>9.17</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Kapaa</td>
      <td>90</td>
      <td>US</td>
      <td>1521500160</td>
      <td>73</td>
      <td>22.08</td>
      <td>-159.32</td>
      <td>75.20</td>
      <td>14.99</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Rikitea</td>
      <td>44</td>
      <td>PF</td>
      <td>1521504314</td>
      <td>100</td>
      <td>-23.12</td>
      <td>-134.97</td>
      <td>79.55</td>
      <td>15.82</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Dayong</td>
      <td>75</td>
      <td>CN</td>
      <td>1521500400</td>
      <td>100</td>
      <td>25.02</td>
      <td>118.29</td>
      <td>60.80</td>
      <td>13.42</td>
    </tr>
  </tbody>
</table>
</div>




```python
sns.set()
raw_time = weather_data_pd.iloc[0,3]
date = time.strftime('%m/%d/%Y',time.gmtime(raw_time))
```


```python
plt.figure(figsize=(10,7))
plt.xlim(-80,100)
plt.ylim(-100,150)
plt.grid(True)
plt.title(f'City Latitude vs. Max Temperature ({date})',fontsize=15)
plt.ylabel("Maximum Temperature (F)",fontsize=13)
plt.xlabel("City Latitude",fontsize=13)
plt.scatter(weather_data_pd["Lat"], weather_data_pd["Max Temp"], facecolors="blue", edgecolors="black", linewidth=1)
plt.savefig("MaximumTemperature.png")
plt.show()
```


![png](output_6_0.png)



```python
plt.figure(figsize=(10,7))
plt.xlim(-80,100)
plt.ylim(-20,120)
plt.grid(True) 
plt.title(f'City Latitude vs. Humidity ({date})',fontsize=15)
plt.xlabel("City Latitude",fontsize=13)
plt.ylabel("Humidity (%)",fontsize=13)
plt.scatter(weather_data_pd["Lat"], weather_data_pd["Humidity"], facecolors="blue", edgecolors="black", linewidth=1)
plt.savefig("Humidity.png")
plt.show()
```


![png](output_7_0.png)



```python
plt.figure(figsize=(10,7))
plt.xlim(-80,100)
plt.ylim(-20,120)
plt.grid(True) 
plt.title(f'City Latitude vs. Cloudiness ({date})',fontsize=15)
plt.xlabel("City Latitude",fontsize=13)
plt.ylabel("Cloudiness (%)",fontsize=13)
plt.scatter(weather_data_pd["Lat"], weather_data_pd["Cloudiness"], facecolors="blue", edgecolors="black", linewidth=1)
plt.savefig("Cloudiness.png")
plt.show()
```


![png](output_8_0.png)



```python
plt.figure(figsize=(10,7))
plt.xlim(-80,100)
plt.ylim(-5,60)
plt.grid(True) 
plt.title(f'City Latitude vs. Wind Speed ({date})', fontsize=15)
plt.xlabel("City Latitude", fontsize=13)
plt.ylabel("Wind Speed (mph)", fontsize=13)
plt.scatter(weather_data_pd["Lat"], weather_data_pd["Wind Speed"], facecolors="blue", edgecolors="black", linewidth=1)
plt.savefig("Wind Speed.png")
plt.show()
```


![png](output_9_0.png)

