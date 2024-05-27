import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit, ViewChild } from '@angular/core';
import { HttpService } from 'src/app/services/http.service';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {

  msg = ''

  @ViewChild('name') name: any
  @ViewChild('email') email: any
  @ViewChild('password') password: any

  constructor(private http: HttpService) { }

  ngOnInit(): void {
  }

  signup(email: string, name: string, password: string) {
    this.http.signup({email, name, password}).subscribe(data => {
      this.msg = "Account created successfully"
      this.name.nativeElement.value = ''
      this.email.nativeElement.value = ''
      this.password.nativeElement.value = ''
    },err => {
      if(err instanceof HttpErrorResponse){
        if(err.status === 409){
          this.msg = "Email already exists"
        }else if(err.status === 500){
          this.msg = "Server Side Error"
        }
      }
    })
  }

}
