#!/bin/env bash
iasl ./SSDT1.dsl 
mv ./SSDT1.aml ./SSDT1.dat

iasl ./SSDT2.dsl
mv ./SSDT2.aml ./SSDT2.dat

iasl ./SSDT3.dsl
mv ./SSDT3.aml ./SSDT3.dat
