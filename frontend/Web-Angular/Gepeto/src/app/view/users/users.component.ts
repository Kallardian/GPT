import { FormBuilder, FormGroup, Validators } from '../../../../node_modules/@angular/forms'
import { Component, OnInit } from '@angular/core';

import { UsersService } from './../../services/users-services/users.service'
import { User } from './../../models/user'
@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  users: User[];
  formUser: FormGroup;
  addMode = false;
  userRA: JSON
  editUser = false;


  constructor(private UsersService: UsersService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.showUsers();
    this.createUserForm();
    this.users = [];
  }
  showUsers() {
    this.UsersService.showUsers()
      .subscribe(data => {
        
        for(let i = 0; i < data.length; i++){
          this.users.push(new User(data[i]["ra"], data[i]["fullName"], data[i]["password"], data[i]["access"]))
        }
      });
  }
  createUserForm() {
    this.formUser = this.fb.group({
      ra: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(6)
        ])
      ],
      fullName: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(30)
        ])
      ],
      password: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(30)
        ])
      ],
      access: [
        '',
        Validators.compose([
          Validators.required,
        ])
      ]
    });
  }
  saveUser(user: FormGroup) {
    this.UsersService.addUser(user.value)
      .subscribe(result => {
        // let completeUser = result.toString()
        
        // this.users.push(result)
        this.formUser.reset()
        // this.userRA = JSON.parse(JSON.stringify(user.value))
        // console.log(this.userRA[0])
        this.users.push(new User(result["ra"], result["fullName"], result["password"], result["access"]))
        alert('Usuário ' + result["fullName"] + ' criado com sucesso')
      },
      erro => {
        if(erro.status == 500){
          alert('O RA "' + user.value["ra"] + '" já existe!')
        }
      }
      )
  }

  changeToAddMode() {
    this.formUser.reset()
    this.addMode = !this.addMode
  }

  editUserOpen(user) {
    this.changeToAddMode()
    this.updateForm(user)
    this.editUser = true
  }
  updateForm(user: User){
    this.formUser.patchValue({
      ra: user.ra,
      fullName: user.fullName,
      password: 123456,
      access: user.access
    })
  }

  sendEditUser(user: FormGroup){
    this.UsersService.editUser(user.value)
    .subscribe(result => {
      console.log(result)
      window.location.reload();
    })
  }

  clearLocal(){
    localStorage.clear();
  }
  accessType(userAccess: number): string{
    switch(userAccess){
      case 2:
       return "Coodenador do Curso"
      case 3:
        return "Professor de Projetos"
      case 4:
        return "Professor Avaliador"
      case 0:
        return "Desabilitado"
    }
  }
}
