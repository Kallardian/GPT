import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  loginUserUrl = '/api/users/login'
  currentUser: number;

  constructor(private http: HttpClient) { }

  loginUser(user: any){
    return this.http.post(this.loginUserUrl, user);
  }
}
