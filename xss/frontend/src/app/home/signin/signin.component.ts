import { Component, OnInit } from '@angular/core';
import { HttpServiceService } from 'src/app/services/http-service.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-signin',
  templateUrl: './signin.component.html',
  styleUrls: ['./signin.component.css']
})
export class SigninComponent implements OnInit {

  msg = ''

  constructor(private http: HttpServiceService, private router: Router) { }

  ngOnInit(): void {

  }

  signin(email: string, password: string, isAdmin: boolean){
    if(email === '' || password === ''){
      if(password === '')
        this.msg = "Password cannot be empty"
      else
        this.msg = "Email cannot be empty"
    }

    else
      this.http.signin({email, password, isAdmin}).subscribe(data =>{
        console.log(data)
        if(data.status === 200){
          window.localStorage.setItem('token', data.body.token)
          this.router.navigate(['/user'])
        }else{
          this.msg = data.body.msg
        }
      })

  }
  

}
