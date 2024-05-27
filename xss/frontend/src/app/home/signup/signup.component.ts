import { Component, OnInit, ViewChild } from '@angular/core';
import { HttpServiceService } from 'src/app/services/http-service.service';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {

  msg = ''
  @ViewChild('name') username: any
  @ViewChild('email') useremail: any
  @ViewChild('password') userPassword: any
  constructor(private http: HttpServiceService) { }

  ngOnInit(): void {
  }

  signup(email: string, name: string, password: string, isAdmin: boolean) {
    if (email === '' || password === '' || name === '') {
      if (email === '')
        this.msg = 'Email cannot be empty'
      else if (password === '')
        this.msg = "Password cannot be empty"
      else
        this.msg = "Name cannot be empty"
    }

    else
      this.http.signup({ email, name, password, isAdmin }).subscribe(data => {
        this.msg = data.body.msg
        console.log(this.msg)
        this.username.nativeElement.value = ''
        this.useremail.nativeElement.value = ''
        this.userPassword.nativeElement.value = ''
      })

  }
}
