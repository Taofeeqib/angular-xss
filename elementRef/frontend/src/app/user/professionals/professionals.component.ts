import { AfterViewChecked, Component, OnInit, ViewChildren, ViewEncapsulation } from '@angular/core';
import { HttpService } from 'src/app/services/http.service';

@Component({
  selector: 'app-professionals',
  templateUrl: './professionals.component.html',
  styleUrls: ['./professionals.component.css'],
  encapsulation: ViewEncapsulation.None
})
export class ProfessionalsComponent implements OnInit, AfterViewChecked {
  ios: any = []
  android: any = []
  fullstack: any = []
  frontend: any = []
  backend: any = []

  @ViewChildren('furl') furl: any
  @ViewChildren('burl') burl: any
  @ViewChildren('iurl') iurl: any
  @ViewChildren('aurl') aurl: any
  @ViewChildren('fsurl') fsurl: any
  

  constructor(private http: HttpService) { }

  ngOnInit(): void {
    this.http.find({token: localStorage.getItem('token')}).subscribe(data => {
      const professionals = data.body.professionals
      for(let i = 0; i < professionals.length; i++){
        switch (professionals[i].profession) {
          case "Full Stack Developer":
            this.fullstack.push({name: professionals[i].name, email: professionals[i].email, url: professionals[i].website})
            break;
          case "Backend Developer":
            this.backend.push({name: professionals[i].name, email: professionals[i].email, url: professionals[i].website})
            break;
          case "Frontend Developer":
            this.frontend.push({name: professionals[i].name, email: professionals[i].email, url: professionals[i].website})
            break;
          case "Android Developer":
            this.android.push({name: professionals[i].name, email: professionals[i].email, url: professionals[i].website})
            break;
          case "IOS Developer":
            this.ios.push({name: professionals[i].name, email: professionals[i].email, url: professionals[i].website})
            break;
        
          default:
            break;
        }
      }
    })
  }

  ngAfterViewChecked(): void {
    const fs = this.fsurl._results
    for(let i = 0; i < fs.length; i++){
      fs[i].nativeElement.href = this.fullstack[i].url
    }
    const b = this.burl._results
    for(let i = 0; i < b.length; i++){
      b[i].nativeElement.href = this.backend[i].url
    }
    const f = this.furl._results
    for(let i = 0; i < f.length; i++){
      f[i].nativeElement.href = this.frontend[i].url
    }
    const a = this.aurl._results
    for(let i = 0; i < a.length; i++){
      a[i].nativeElement.href = this.android[i].url
    }
    const io = this.iurl._results
    for(let i = 0; i < io.length; i++){
      io[i].nativeElement.href = this.ios[i].url
    }
  }


}
