import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { Router } from '@angular/router';
import { HttpService } from 'src/app/services/http.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css'],
  encapsulation: ViewEncapsulation.None
})
export class ProfileComponent implements OnInit {

  
  username: string = ''
  useremail: string = ''
  userprofession: string = ''
  userurl: string = ''
  msg: string = ''

  constructor(private http: HttpService, private router: Router) { }

  ngOnInit(): void {    
    const k: any = this.http.getUserInfo()
    this.username = k.name
    this.useremail = k.email
    this.userprofession = k.profession
    this.userurl = k.url
  }

  update(email: string, name: string, url: string, profession: string){
    const info = {token: localStorage.getItem('token'), details: {email, name, website: url, profession}}
    this.http.update(info).subscribe(data => {
      this.msg = ''
      localStorage.setItem('token', data.body.token)
      window.location.reload()
    }, err => {
      if(err instanceof HttpErrorResponse){
        if(err.status === 401){
          localStorage.removeItem('token')
          this.router.navigate([''])
        }else if(err.status === 500){
          this.msg = "Server Side Error"
        }
      }
    })
  }

}
