import { GroupsService } from 'src/app/services/groups-services/groups.service';
import { Component, OnInit } from '@angular/core';
import { delay } from 'rxjs/operators';
import { FormBuilder, FormGroup, Validators } from '../../../../node_modules/@angular/forms'

import { LoginService } from './../../services/login-services/login.service';




@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  formLogin: FormGroup;
  currentUser: number;

  constructor(private fb: FormBuilder,
              private LoginService: LoginService,
              private GroupService: GroupsService) { }

  ngOnInit(): void {
    this.createLoginForm();
  }

  createLoginForm() {
    this.formLogin = this.fb.group({
      ra: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(6)
        ])
      ],
      password: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(30)
        ])]
    });
  }

  sendLogin(form: any) {
    this.GroupService.changeCurrentUser(this.currentUser)
    window.alert(this.LoginService.currentUser)
    this.LoginService.loginUser(form)
    .subscribe(result =>{
      console.log(form);
      console.log(result);
      switch(result){
        case 1:
          window.location.href="http://localhost:4200/users"
          break;
        case 2:
          window.location.href="http://localhost:4200/criteria"
          break;
        case 3:
          window.location.href="http://localhost:4200/classrooms"
          break;
        case 0:
          window.alert('Seus dados estão errados, ou está com o usuário inativo')
          break;
        default:
          window.alert('Você não tem permissão para entrar aqui.')
      }
      this.formLogin.reset();
    });
  }
}
