{
  "spriteId": {
    "name": "spr_circle",
    "path": "sprites/spr_circle/spr_circle.yy",
  },
  "solid": false,
  "visible": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "par_completable",
    "path": "objects/par_completable/par_completable.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,"parent":{"name":"obj_objective_circle","path":"objects/obj_objective_circle/obj_objective_circle.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":8,"collisionObjectId":null,"parent":{"name":"obj_objective_circle","path":"objects/obj_objective_circle/obj_objective_circle.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,"parent":{"name":"obj_objective_circle","path":"objects/obj_objective_circle/obj_objective_circle.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":12,"collisionObjectId":null,"parent":{"name":"obj_objective_circle","path":"objects/obj_objective_circle/obj_objective_circle.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":6,"value":"\"inside\"","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[
        "\"inside\"",
        "\"insideRotation\"",
        "\"shoot\"",
      ],"multiselect":false,"filters":[
        "GMSprite",
      ],"resourceVersion":"1.0","name":"type","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":1,"value":"120","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"completionMax","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"1","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"completionDecay","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"0","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"completionDecayDelay","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"60","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"completionDecayDelayMax","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [],
  "parent": {
    "name": "Objects",
    "path": "folders/Objects.yy",
  },
  "resourceVersion": "1.0",
  "name": "obj_objective_circle",
  "tags": [],
  "resourceType": "GMObject",
}