import { Component, OnInit, ViewChild } from '@angular/core';
import { HttpServiceService } from 'src/app/services/http-service.service';

@Component({
  selector: 'app-add-movies',
  templateUrl: './add-movies.component.html',
  styleUrls: ['./add-movies.component.css']
})
export class AddMoviesComponent implements OnInit {

  msg = ''
  @ViewChild('link') movieLink: any
  @ViewChild('name') movieName: any
  constructor(private http: HttpServiceService) { }

  ngOnInit(): void {

  }

  add(name: string, link: string){
    const data = {name, link, token: window.localStorage.getItem('token')}
    this.http.addMovie(data).subscribe(data => {
      this.msg = data.body.msg
      this.movieLink.nativeElement.value = ''
      this.movieName.nativeElement.value = ''
    })
  }

}
