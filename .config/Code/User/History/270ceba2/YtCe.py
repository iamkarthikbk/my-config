import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ReadOnly, ClockCycles
from cocotb.log import SimLogFormatter, SimColourLogFormatter, SimLog, SimTimeContextFilter
from cocotb.result import TestFailure, TestSuccess, SimFailure, SimTimeoutError
from datetime import datetime
import os
import logging
from logging.handlers import RotatingFileHandler
import time
from utils import *
from dataclasses import dataclass


class Tb:
    '''
        Base class for crypto-accel testbench
    '''

    def __init__(self, dut):
        self.dut = dut  # set up the logger
        self.logger = logging.getLogger("cocotb")
        self.logger.setLevel(logging.DEBUG)
        self.log_file_name = 'sim.log'
        fh = logging.FileHandler(self.log_file_name, mode='w')
        fh.setLevel(logging.INFO)
        formatter = logging.Formatter(
            '%(asctime)s | %(levelname)s | %(message)s')
        fh.setFormatter(formatter)
        self.logger.addHandler(fh)
        self.stop_sim = False

    @cocotb.coroutine
    def wait_for_end(self):
        """
            This routine will wait endlessly until an exception is raised
        """
        cycle_count = 0
        while self.stop_sim == False:
            yield RisingEdge(self.dut.CLK)

    @cocotb.coroutine
    def validate_inputs(self, valid_inp, clk_signal):
        '''
            enables EN_ma_request signal in the DUT for a single clock cycle.
            Inputs
            valid_inp : The EN_ma signal
            clk_signal: The signal corresponding to the clock of the DUT
        '''
        valid_inp.value = 1
        yield RisingEdge(clk_signal)
        valid_inp.value = 0

    @cocotb.coroutine
    def wait_for_outputs(self, resp_RDY):
        '''
            Waits for the RDY signal. Detects posedge and waits until completion
        '''
        yield RisingEdge(resp_RDY)
        yield FallingEdge(resp_RDY)

    @cocotb.coroutine
    def drive_inputs(self, rdy, clk_signal):
        """
        Used to control the rdy signal to drive inputs from test_Zbp.py
        
        Args:
            rdy: the ready signal
            clk_signal: The signal corresponding to the clock of the DUT should be
                        passed here
        """
        yield RisingEdge(clk_signal)
        yield Timer(1,units="ps")
        if rdy.value.integer != 1:
            yield RisingEdge(rdy)


@cocotb.coroutine
def assert_reset(rst_signal, rst_val, rstn_val, rst_delay):
    '''
    This coroutine can be used to reset DUT.
    Inputs
    rst_signal: The signal corresponding to the reset of the DUT should be
                passed here
    rst_val   : The value which needs to be assigned to the signal to assert
                 reset
    rstn_val  : The value which needs to be assigned to the signal after the
                 reset is done
    rst_delay : The delay required before the rstn_val is assigned to the
                 signal
    '''
    rst_signal.value = rst_val
    yield Timer(rst_delay, units="ns")
    rst_signal.value = rstn_val
