import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { HttpServiceService } from 'src/app/services/http-service.service';

@Component({
  selector: 'app-movies',
  templateUrl: './movies.component.html',
  styleUrls: ['./movies.component.css'],
  encapsulation: ViewEncapsulation.None
})
export class MoviesComponent implements OnInit {


  myDataArray = [
    {name: 'movie', link: 'https://www.google.com'},
    {name: 'movie', link: 'https://www.google.com'},
    {name: 'movie', link: 'https://www.google.com'},
    {name: 'movie', link: 'https://www.google.com'},
    {name: 'movie', link: 'https://www.google.com'},
    {name: 'movie', link: 'https://www.google.com'},
    {name: 'movie', link: 'https://www.google.com'},
    {name: 'movie', link: 'https://www.google.com'},
    {name: 'movie', link: 'https://www.google.com'},
    {name: 'movie', link: 'https://www.google.com'},
  ]
  constructor(private sanitizer: DomSanitizer, private http: HttpServiceService) { }

  ngOnInit(): void {
    this.http.getMovies().subscribe(data => {
      if(data.status === 202){
        this.myDataArray = []
      }else{
        this.myDataArray = data.body.movies
      }
    })
  }


  getMovieLink(link: string){
    return this.sanitizer.bypassSecurityTrustHtml(`<a class='link' href ="${link}">Click here</a>`)
  }

}
