// ./lib/Util.js
const AUTHOR = 'YAMADA, Yoshihiro'

//モジュールとして読み込むことができるようにexportを記述
//外部で利用したいクラスに『export』を付けることで『import』が可能となります。
export class Member {
  constructor(firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName
  }

  getName() {
    return this.firstName + this.lastName
  }
}
