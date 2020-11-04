import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class UsersService {
  readonly apiURL: string;
  


  constructor(private http: HttpClient) {
    this.apiURL = 'http://localhost:3001'
   }

  showUsers(){
    return this.http.get<any[]>(`${this.apiURL}/users`)
  }
  deleteUser(userId: number){
    return this.http.delete<any[]>(`${this.apiURL}/users/` + userId)
  }
}
