import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { HttpService } from 'src/app/services/http.service';

@Component({
  selector: 'app-signin',
  templateUrl: './signin.component.html',
  styleUrls: ['./signin.component.css']
})
export class SigninComponent implements OnInit {
  msg = ''
  constructor(private http: HttpService, private router: Router) { }

  ngOnInit(): void {
  }

  signin(email: string, password: string){
    this.http.signin({email, password}).subscribe(data => {
      localStorage.setItem('token', data.body.token)
      this.router.navigate(['/user'])
    }, err => {
      if(err instanceof HttpErrorResponse){
        if(err.status == 402){
          this.msg = 'Email or password is wrong'
        }else if(err.status == 500){
          this.msg = "Server Side error"
        }
      }
    })
  }

}
