import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class HttpServiceService {

  url = 'http://localhost:8000/'

  constructor(private client: HttpClient) { }

  signup(data: any){
    return this.client.post<any>(this.url + 'signup', data, {observe: 'response'})
  }
  
  signin(data: any){
    return this.client.post<any>(this.url + 'signin', data, {observe: 'response'})
  }

  check(token: any){
    return this.client.post<any>(this.url + 'check', token, {observe: 'response'})
  }

  getMovies(){
    return this.client.get<any>(this.url + "movies?token=" + localStorage.getItem('token'), {observe: 'response'})
  }

  addMovie(data:any){
    return this.client.post<any>(this.url + 'movies', data, {observe: 'response'})
  }

  update(data:any){
    return this.client.post<any>(this.url + "update", data, {observe: 'response'})
  }

  
}
