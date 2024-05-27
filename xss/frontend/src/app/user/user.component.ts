import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { SELECT_PANEL_MAX_HEIGHT } from '@angular/material/select/select';
import { HttpServiceService } from '../services/http-service.service';
import {Router} from '@angular/router'

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css'],
  encapsulation: ViewEncapsulation.None
})
export class UserComponent implements OnInit {

  name = ''
  isAdmin = false
  constructor(private http: HttpServiceService, private router: Router) { }

  ngOnInit(): void {
    if(window.localStorage.getItem('token')){
      this.http.check({token: window.localStorage.getItem('token')}).subscribe(data => {
        if(data.body.signedin){
          this.name = data.body.name
          this.isAdmin = data.body.isAdmin
        }else{
          window.localStorage.removeItem('token')
          this.router.navigate(['/'])
        }
      })
    }else{
      this.router.navigate(['/'])
    }
  }

  logout(){
    window.localStorage.removeItem('token')
    this.router.navigate(['/'])
  }

}
