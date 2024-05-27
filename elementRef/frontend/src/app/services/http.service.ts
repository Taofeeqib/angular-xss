import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import jwtDecode from 'jwt-decode';

@Injectable({
  providedIn: 'root'
})
export class HttpService {

  url = 'http://localhost:8000/'

  constructor(private http: HttpClient) { }

  signup(data: any){
    return this.http.post<any>(this.url + "signup", data, {observe: 'response'})
  }

  signin(data: any){
    return this.http.post<any>(this.url + 'signin', data, {observe: 'response'})
  }

  getUserInfo(): any{
    const k = window.localStorage.getItem('token')
    try {
      const data = jwtDecode(k ? k : "")
      return data
    } catch (error) {
      return false
    }
  }

  update(data: any){
    return this.http.post<any>(this.url + 'update', data, {observe: 'response'})
  }

  find(data: any){
    return this.http.post<any>(this.url + 'find', data, {observe: 'response'})
  }

}
