import { Component, OnInit } from '@angular/core';
import { HttpServiceService } from 'src/app/services/http-service.service';

@Component({
  selector: 'app-edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.css']
})
export class EditComponent implements OnInit {

  username:any = null
  useremail:any = null
  constructor(private http: HttpServiceService) { }

  ngOnInit(): void {
    this.http.check({token: window.localStorage.getItem('token')}).subscribe(data => {
      this.username = data.body['name']
      this.useremail = data.body['email']
    })
  }

  update(email: string, name: string){
    this.http.update({email, name, token: window.localStorage.getItem('token')}).subscribe(data => {
      if(data.status === 200){
        window.location.reload()
      }
    })
  }

}
