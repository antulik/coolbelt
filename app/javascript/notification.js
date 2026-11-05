import Notify from 'simple-notify'
import { Turbo } from "@hotwired/turbo-rails"
import {Utils} from "turbo_power";


const PERMITTED_ATTRIBUTES = [
  "status",
  "title",
  "text",
  "speed",
  "autotimeout",
]

// https://github.com/simple-notify/simple-notify
function notify() {
  // console.log(this.attributes)

  const attributes = Array.from(this.attributes)
    .filter((attribute) => PERMITTED_ATTRIBUTES.includes(attribute.name))
    .map((attribute) => [Utils.camelize(attribute.name), Utils.typecast(attribute.value)])

  const options = Object.fromEntries(attributes)

  new Notify({
    status: 'success',
    title: null,
    text: null,
    effect: 'fade',
    speed: 300,
    customClass: null,
    customIcon: null,
    showIcon: true,
    showCloseButton: true,
    autoclose: true,
    autotimeout: 5000,
    gap: 20,
    distance: 20,
    type: 'outline',
    position: 'right top',
    ...options
  })
}

Turbo.StreamActions.notify = notify

