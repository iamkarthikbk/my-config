import cocotb
from cocotb.triggers import Timer, RisingEdge
from cocotb_coverage.coverage import *
from env import *
import user_config
import checker

log = cocotb.logging.getLogger("cocotb")

@cocotb.test()
def single_scalar(dut):
    """Drives a single private key to the DUT and verifies it's result.
    """

    tb = Tb(dut)
    tb.logger.info('Starting Simulation')
    yield tb.start_sim(clk_delay=5, rst_delay=200)
    yield tb.drive_inputs(dut.RDY_ma_request_ops, tb.dut.CLK)
    dut.ma_request_ops_priv_key.value = 0xdeadbeefbabecafe
    cocotb.fork(tb.validate_inputs(dut.EN_ma_request_ops, tb.dut.CLK))
    cocotb.fork(tb.count_clock())
    yield tb.wait_for_outputs(dut.RDY_mv_pubkey_fst)
    tb.logger.info('Ending Simulation')