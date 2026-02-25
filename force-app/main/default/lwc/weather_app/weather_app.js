import {LightningElement, track } from 'lwc';
import SNOW_WEATHER from '@salesforce/resourceUrl/snow_weather';
import RAIN_WEATHER from '@salesforce/resourceUrl/rainy';
import SUNNY_WEATHER from '@salesforce/resourceUrl/sunny_weather';
import mostlycloud from '@salesforce/resourceUrl/mostly_cloudy';
import getDaily from '@salesforce/apex/WeatherApi.daily';
import getState from '@salesforce/apex/WeatherApi.getlocation';
import CLOUDY from '@salesforce/resourceUrl/night_cloudy';
import bg from '@salesforce/resourceUrl/bg';
import thunderCloudbg from '@salesforce/resourceUrl/thunderCloud';
import rainWeatherbg from '@salesforce/resourceUrl/rainWeather';
import sunnyWeatherbg from '@salesforce/resourceUrl/sunnyWeather';
import chartjs from '@salesforce/resourceUrl/chart';
import { loadScript} from 'lightning/platformResourceLoader';
import getHours from '@salesforce/apex/WeatherApi.getHours';

export default class Weather_app extends LightningElement {
    //AjDiqktNCTBEAGDty0VpBJcHYJFptEDn UNysUrPyafIwu5Sy5MCjGPRUdovOPqmu whuLmQGiU0ORAtfKa5R1Gavw3TY3yojr ROumAcw7LRVp6rAyb539XYQDX1ADKom4
    weather;   //day weather
    temprature = 90;
    location = 'Dehradun';
    region = ', India';
    snow = SNOW_WEATHER;
    rainy = RAIN_WEATHER;
    sunny = SUNNY_WEATHER;
    type = '°F';
    backgroundIMG;
    locationKey = '191339';
    @track dailyobj = [];
    @track dailyobj2 = [];
    apiKey = 'ROumAcw7LRVp6rAyb539XYQDX1ADKom4';
    dailytemprature;
    searchKey = '';
    time;
    icon_nightCloud;
    date = new Date();
    headline;
    background = bg;
    right = 0;
    selected_position = 0;
    hourlyObj = [];
    hourlyObj1 = [];
    icon_phase;
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    dayLongPhrase;
    nightLongPhrase;
    sunrise;
    sunset;
    moonrise;
    moonset;
    Precipitation = 0;
    MaxWind = 0;

    //imgicons
    ic_1 = 'https://developer.accuweather.com/sites/default/files/01-s.png';
    ic_2 = 'https://developer.accuweather.com/sites/default/files/02-s.png';
    ic_3 = 'https://developer.accuweather.com/sites/default/files/03-s.png';
    ic_4 = 'https://developer.accuweather.com/sites/default/files/04-s.png';
    ic_5 = 'https://developer.accuweather.com/sites/default/files/05-s.png';
    ic_6 = 'https://developer.accuweather.com/sites/default/files/06-s.png';
    ic_7 = 'https://developer.accuweather.com/sites/default/files/07-s.png';
    ic_8 = 'https://developer.accuweather.com/sites/default/files/08-s.png';
    ic_11 = 'https://developer.accuweather.com/sites/default/files/11-s.png';
    ic_12 = 'https://developer.accuweather.com/sites/default/files/12-s.png';
    ic_13 = 'https://developer.accuweather.com/sites/default/files/13-s.png';
    ic_14 = 'https://developer.accuweather.com/sites/default/files/14-s.png';
    ic_15 = 'https://developer.accuweather.com/sites/default/files/15-s.png';
    ic_16 = 'https://developer.accuweather.com/sites/default/files/16-s.png';
    ic_17 = 'https://developer.accuweather.com/sites/default/files/17-s.png';
    ic_18 = 'https://developer.accuweather.com/sites/default/files/18-s.png';
    ic_19 = 'https://developer.accuweather.com/sites/default/files/19-s.png';
    ic_20 = 'https://developer.accuweather.com/sites/default/files/20-s.png';
    ic_21 = 'https://developer.accuweather.com/sites/default/files/21-s.png';
    ic_22 = 'https://developer.accuweather.com/sites/default/files/22-s.png';
    ic_23 = 'https://developer.accuweather.com/sites/default/files/23-s.png';
    ic_24 = 'https://developer.accuweather.com/sites/default/files/24-s.png';
    ic_25 = 'https://developer.accuweather.com/sites/default/files/25-s.png';
    ic_26 = 'https://developer.accuweather.com/sites/default/files/26-s.png';
    ic_27 = 'https://developer.accuweather.com/sites/default/files/27-s.png';
    ic_28 = 'https://developer.accuweather.com/sites/default/files/28-s.png';

    get backgroundStyle() {
        return `height:100vh; background-image:url(${this.backgroundIMG})`;
    }


    connectedCallback() {

        getDaily({ apiKey: this.apiKey, location: this.locationKey }).then((res) => {
            console.log("Response" + res);
            this.obj = res;
            console.log("dataOBJ==>" + JSON.stringify(this.obj));
            this.setData(this.obj);
            this.time = new Date().toLocaleString('en-US', {
                hour: 'numeric',
                minute: 'numeric',
                hour12: true
            })
            console.log("time=>" + this.time);
        });
        this.checkweather();
        this.gethour();
    }

    checkweather() {
        if (this.weather === 'Rain') {
            //this.backgroundIMG = this.rainy;
            this.background = rainWeatherbg;
        } else
            if (this.weather === 'Snow') {
                // this.backgroundIMG = this.snow;
                this.background = bg;
            } else
                if (this.weather === 'Sunny') {
                    //this.backgroundIMG = this.sunny;
                    this.background = sunnyWeatherbg;
                } else
                    if (this.weather === 'T-Storms') {
                        this.background = thunderCloudbg;
                    } else if (this.icon_phase === 'Mostly cloudy') {
                        this.background = mostlycloud;
                    } else {
                        this.background = mostlycloud;
                    }
    }

    handleKeyUp(event) {
        if (event.keyCode === 13) {
            this.type = '°F';
            this.searchKey = event.target.value;
            console.log('search key==>' + this.searchKey);
            getState({ apiKey: this.apiKey, state: this.searchKey }).then((res) => {
                console.log("Response" + res);
                this.locationKey = res[0].Key;
                console.log('location key==>' + this.locationKey);
                this.location = res[0].LocalizedName;
                this.connectedCallback();
            });
            this.gethour();
            console.log("hourObj==>" + JSON.stringify(this.hourlyObj1));

        }
    }

    gethour() {
        getHours({ apiKey: this.apiKey, locationcode: this.locationKey }).then((res) => {
            this.hourlyObj = [];
            this.hourlyObj = res;
            this.hourlyObj1 = [];
            console.log("hourly==>" + this.hourlyObj);
            this.hourlyObj.forEach(Element => {
                console.log("element==>" + JSON.stringify(Element));
                this.hourlyObj1.push(Number(Element.Temperature.Value));
                console.log("json==>" + JSON.stringify(this.hourlyObj1));
            });
            this.config.data.datasets[0].data = [];
            this.config.data.datasets[0].data = this.hourlyObj1;
            this.chart = new window.Chart(this.ctx, this.config);
            console.log("config==>" + JSON.stringify(this.config.data.datasets[0].data));
        });
        this.getgraph();
    }

    setData(weatherObj) {
        this.temprature = weatherObj.DailyForecasts[0].Temperature.Maximum.Value;
        this.weather = weatherObj.DailyForecasts[0].Day.PrecipitationType;
        this.icon_phase = weatherObj.DailyForecasts[0].Day.IconPhrase;
        console.log('weather==>' + this.weather);
        console.log('width==>' + window.innerWidth);
        this.checkweather();
        this.dailyobj = weatherObj.DailyForecasts;
        this.headline = weatherObj.Headline.Text;
        this.dailyobj2 = [];
        this.dailyobj.forEach(Element => {
            this.dailyobj2.push({
                'maximum': Element.Temperature.Maximum.Value,
                'minimum': Element.Temperature.Minimum.Value,
                'icon': this.getIconUrl(Element.Day.Icon),
                'day': this.days[new Date(Element.Dates).getDay()]
            });
        });
        this.icon_nightCloud = this.dailyobj2[0].icon;
        this.dayLongPhrase = weatherObj.DailyForecasts[0].Day.LongPhrase;
        this.nightLongPhrase = weatherObj.DailyForecasts[0].Night.LongPhrase;
        this.sunrise = new Date(weatherObj.DailyForecasts[this.selected_position].Sun.Rise).toLocaleString('en-US', {
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });
        this.sunset = new Date(weatherObj.DailyForecasts[this.selected_position].Sun.Sets).toLocaleString('en-US', {
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });
        this.moonrise = new Date(weatherObj.DailyForecasts[this.selected_position].Moon.Rise).toLocaleString('en-US', {
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });
        this.moonset = new Date(weatherObj.DailyForecasts[this.selected_position].Moon.Sets).toLocaleString('en-US', {
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });
        this.Precipitation = weatherObj.DailyForecasts[this.selected_position].Day.PrecipitationProbability;
        this.MaxWind = weatherObj.DailyForecasts[this.selected_position].Day.Wind.Speed.Value;
        console.log('::207==>'+this.Precipitation+'::=>'+this.MaxWind+'::=>'+this.calcpercent(this.Precipitation));
        this.setProgress(this.Precipitation,'.first');
        this.setProgress(this.MaxWind,'.second');
        // this.template.querySelector(".perception").style = `stroke-dasharray="219.91148575129"; stroke-mitterlimit="0"; stroke-dashoffset: ${Number(this.calcpercent(this.Precipitation))};`;
        // this.template.querySelector(".maxwind").style = `stroke-dasharray="219.91148575129"; stroke-mitterlimit="0"; stroke-dashoffset: ${Number((this.MaxWind/100)*360)};`;
    }

    calcpercent(data){
        return 2*(data/100)*360;
    }

    getIconUrl(code) {
        switch (code) {
            case 1:
                return this.ic_1;
            case 2:
                return this.ic_2;
            case 3:
                return this.ic_3;
            case 4:
                return this.ic_4;
            case 5:
                return this.ic_5;
            case 6:
                return this.ic_6;
            case 7:
                return this.ic_7;
            case 8:
                return this.ic_8;
            case 11:
                return this.ic_11;
            case 12:
                return this.ic_12;
            case 13:
                return this.ic_13;
            case 14:
                return this.ic_14;
            case 15:
                return this.ic_15;
            case 16:
                return this.ic_16;
            case 17:
                return this.ic_17;
            case 18:
                return this.ic_18;
            case 19:
                return this.ic_19;
            case 20:
                return this.ic_20;
            case 21:
                return this.ic_21;
            case 22:
                return this.ic_22;
            default:
                return this.ic_1;
        }

    }

    switchTemprature(convert) {
        if (convert === '°C') {
            this.temprature = Math.round(this.temprature * 1.8 + 32);
        }
        if (convert === '°F') {
            this.temprature = Math.round((this.temprature - 32) / 1.8);
        }
    }

    changeType() {
        console.log("type B=>" + this.type);
        this.switchTemprature(this.type);
        if (this.type === '°C') {
            this.type = '°F';
        } else {
            this.type = '°C';
        }
        console.log("type=>" + this.type);
    }

    get setIcon() {
        return `content: url(${CLOUDY})`;
    }

    get getbackground() {
        return `height: 100%;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover; background-image:url(${this.background})`;
    }

    slideRight() {

        if (window.innerWidth >= 1500) {
            this.right = this.right + 190;
        } else if (window.innerWidth <= 1499 && window.innerWidth >= 800) {
            this.right = this.right + 220;
        } else {
            this.right = this.right + 260;
        }
        this.template.querySelector(".slider").style = `margin-left:${this.right}px`;
    }

    slideLeft() {
        if (window.innerWidth >= 1500) {
            this.right = this.right - 190;
        } else if (window.innerWidth <= 1499 && window.innerWidth >= 800) {
            this.right = this.right - 220;
        } else {
            this.right = this.right - 260;
        }
        this.template.querySelector(".slider").style = `margin-left:${this.right}px`;
    }

    active(event) {
        this.type = '°F';
        this.selected_position = event.currentTarget.dataset.id;
        this.temprature = this.obj.DailyForecasts[this.selected_position].Temperature.Maximum.Value;
        this.headline = this.obj.Headline.Text;
        this.weather = this.obj.DailyForecasts[this.selected_position].Day.PrecipitationType;
        this.checkweather();
        this.icon_nightCloud = this.dailyobj2[this.selected_position].icon;
        let i = 0;
        while (i < 5) {
            this.template.querySelector(`[data-id="${i}"]`).classList.remove('active');
            i++;
        }
        this.template.querySelector(`[data-id="${this.selected_position}"]`).classList.add('active');
        console.log("::351");
        this.dayLongPhrase = this.obj.DailyForecasts[this.selected_position].Day.LongPhrase;
        console.log("::351");
        this.nightLongPhrase = this.obj.DailyForecasts[this.selected_position].Night.LongPhrase;
        console.log("::351");
        this.sunrise = new Date(this.obj.DailyForecasts[this.selected_position].Sun.Rise).toLocaleString('en-US', {
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });
        console.log("::351");
        this.sunset = new Date(this.obj.DailyForecasts[this.selected_position].Sun.Sets).toLocaleString('en-US', {
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });
        console.log("::351");
        this.moonrise = new Date(this.obj.DailyForecasts[this.selected_position].Moon.Rise).toLocaleString('en-US', {
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });
        console.log("::351");
        this.moonset = new Date(this.obj.DailyForecasts[this.selected_position].Moon.Sets).toLocaleString('en-US', {
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });
        console.log("::351");
        this.Precipitation = this.obj.DailyForecasts[this.selected_position].Day.PrecipitationProbability;
        this.MaxWind = this.obj.DailyForecasts[this.selected_position].Day.Wind.Speed.Value;
        this.setProgress(this.Precipitation,'.first');
        this.setProgress(this.MaxWind,'.second');
        // this.template.querySelector(".perception").style = `stroke-dashoffset: ${this.calcpercent(this.Precipitation)}`;
        // this.template.querySelector(".MaxWind").style = `stroke-dashoffset: ${this.MaxWind}`;
    }

    error;
    chart;
    chartjsInitialized = false;

    @track config = {
        type: 'line',
        data: {
            datasets: [
                {
                    data: [],
                    fill: false,
                    backgroundColor: 'rgba(0, 217, 255, 0.567)',
                    borderColor: 'rgba(0, 217, 255, 0.567)',
                    tension: 0.4,
                    label: '°Deg'
                }
            ],
            labels: ['7AM', '8AM', '9AM', '10AM', '11AM', '12AM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM']
        },
        options: {
            animations: {
                radius: {
                    duration: 400,
                    easing: 'linear',
                    loop: (context) => context.active
                }
            },
            hoverRadius: 20,
            interaction: {
                mode: 'nearest',
                intersect: false,
                axis: 'x',
                plugins: {
                    tooltip: {
                        enabled: false
                    }
                },
                animation: {
                    animateScale: true,
                    animateRotate: true
                },
                suggestedMin: -10,
                suggestedMax: 200
            }
        }
    };

    ctx;
    getgraph() {
        console.log("in rendercallback::");
        if (this.chartjsInitialized) {
            return;
        }
        this.chartjsInitialized = true;

        loadScript(this, chartjs)
            .then(() => {
                const canvas = document.createElement('canvas');
                this.template.querySelector('div.chart').appendChild(canvas);
                this.template.querySelector('div.chart').style = `margin-right: auto;
                margin-left: auto;`;
                this.ctx = canvas.getContext('2d');
                this.chart = new window.Chart(this.ctx, this.config);
            })
            .catch((error) => {
                this.error = error;
            });
    }
    circumference = 2 * Math.PI * 52;
    setProgress(percent,selected){
        this.template.querySelector(selected).style.strokeDasharray = `${this.circumference} ${this.circumference}`;
        this.template.querySelector(selected).style.strokeDashoffset = `${this.circumference}`;
        let offset = this.circumference - percent / 100 * this.circumference;
        this.template.querySelector(selected).style.strokeDashoffset = offset;
    }

}