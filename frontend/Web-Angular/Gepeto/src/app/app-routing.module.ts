import { CriteriaComponent } from './view/criteria/criteria.component';
import { UsersComponent } from './view/users/users.component';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './view/login/login.component'
import { ClassroomsComponent } from './view/classrooms/classrooms.component'
import { GroupsComponent } from './view/groups/groups.component'



const routes: Routes = [
  { path: '', component: LoginComponent},
  { path: 'classrooms', component: ClassroomsComponent },
  { path: 'groups', component: GroupsComponent },
  { path: 'users', component: UsersComponent },
  { path: 'criteria', component: CriteriaComponent }

];
 
@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
