import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from './guard/auth.guard';
import { LogGuard } from './guard/log.guard';
import { HomeComponent } from './home/home.component';
import { ProfessionalsComponent } from './user/professionals/professionals.component';
import { ProfileComponent } from './user/profile/profile.component';
import { UserComponent } from './user/user.component';

const routes: Routes = [
  {
    path: '',
    component: HomeComponent,
    canActivate: [LogGuard]
  },
  {
    path: 'user',
    component: UserComponent,
    canActivate: [AuthGuard],
    children:[
      {path: '', component: ProfileComponent},
      {path: 'professionals', component: ProfessionalsComponent}
    ]
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
