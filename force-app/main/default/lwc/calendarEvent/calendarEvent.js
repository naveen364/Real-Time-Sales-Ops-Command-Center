import { LightningElement, track } from 'lwc';

export default class CalendarEvent extends LightningElement {
  @track listofDate = [];
  TotalNumberofDay = 0;
  PrevTotalNumberofDay = 0;
  dateNumber = 1;
  @track months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  @track days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  blankcell = 1;
  @track monthName;

  @track month;
  @track year = new Date().getFullYear();

  loadCalendar(){
    this.listofDate = [];
    this.PrevTotalNumberofDay = [];
    this.TotalNumberofDay = new Date(this.year,this.month+1,0).getDate();
    console.log(' this.TotalNumberofDay = new Date(this.year,this.month+1,0).getDate();',this.TotalNumberofDay);
    this.PrevTotalNumberofDay = new Date(this.year,this.month,0).getDate();
    console.log(' this.PrevTotalNumberofDay = new Date(this.year,this.month,0).getDate();',this.PrevTotalNumberofDay);
    let revNum = this.PrevTotalNumberofDay-this.getCustomDate(this.year,this.month,1).getDay()+1;
    //do something with blank space
    while(this.blankcell <= this.getCustomDate(this.year,this.month,1).getDay()){
      this.listofDate.push({
        'date':revNum,
        'month':' ',
        'day':' ',
        'isCurrent':' ',
        'Year':' ',
        'event':'Test'
      });
      this.blankcell++;
      revNum++;
    }
    for(this.dateNumber=1; this.dateNumber<=this.TotalNumberofDay;this.dateNumber++){
      this.listofDate.push({
        'date':this.dateNumber,
        'month':this.months[this.getCustomDate(this.year,this.month,this.dateNumber).getMonth()],
        'day':this.days[this.getCustomDate(this.year,this.month,this.dateNumber).getDay()],
        'isCurrent':this.checkCurrentDate(this.year,this.month,this.dateNumber),
        'Year':this.getCustomDate(this.year,this.month,this.dateNumber).getFullYear(),
        'event':'Test'
      });
    }
    console.log('date=>',JSON.stringify(this.listofDate,null,'\t'));
  }

//method return boolean at condition of current date
  checkCurrentDate(year,month,date){
    return (new Date().getFullYear() == year && new Date().getMonth() == month && new Date().getDate() == date)? true:false;
  }


  //get date
  getCustomDate(year,month,date){
    return new Date(year,month,date);
  }

  connectedCallback(){
    this.month = new Date().getMonth();
    this.loadCalendar();
    this.getMonthName();
  }

  preMonth(){
    this.month--;
    this.loadCalendar();
    this.getMonthName();
  }

  nxtMonth(){
    this.month++;
    this.loadCalendar();
    this.getMonthName();
  }

  getMonthName(){
    this.monthName = this.months[this.month];
  }
}