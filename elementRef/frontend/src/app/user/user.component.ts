import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { Router } from '@angular/router';
import { HttpService } from '../services/http.service';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css'],
  encapsulation: ViewEncapsulation.None
})
export class UserComponent implements OnInit {

  constructor(private router: Router, private http: HttpService) { }
  name = ''
  ngOnInit(): void {
    const k = this.http.getUserInfo()
    console.log(k)
    if(!k){
      this.logout()
    }else{
      this.name = k.name
    }
  }

  logout() {
    localStorage.removeItem('token')
    this.router.navigate([''])
  }
}
