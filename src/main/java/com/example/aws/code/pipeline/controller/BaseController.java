package com.example.aws.code.pipeline.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/v1")
public class BaseController {

    @GetMapping(path = "/ping")
    public ResponseEntity<String> ping(){
     return new ResponseEntity<>("LIVENS", HttpStatus.OK);
    }

}
