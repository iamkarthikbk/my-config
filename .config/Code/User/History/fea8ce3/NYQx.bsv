package TB;
    import exponent :: * ;
    module mkTb(Empty);
        Reg#(Bool) rdy <- mkReg(False);
        // Reg#(ExponentInput#(2048)) rg_inp <- mkReg(ExponentInput{
        //     data_A: 2048'h3EF8F0B6A84A7C9F60C53609493A6E5D97550553669A8FF328051AD8918A29A7C714E0F32DDC5C12097C53F50EAE335EEF73081E66D54AC2334C278E016417DD9E562BFA43B11E3913B923D6162F0D9D0779D53EE54C2CC7F7A57982DE24755209FCF142CC0062DC51F0567FDD21312CCEE613EFF40597E20980E8E2E7972067D771ED20A7DFCA15727B777A243E19335404A6DBB0FBAC64D73AC9F1436E40BED14745E6DFC26C8BB7813901CB1D9FF2FFE49D72C542E7DB928DF7E46F7CBB54C60862B1FFDEA43767956F1C8F46F0952E5BAA83FCA5ADB92C9C555E1160648F97B129E1FA121B20BFAA7631E79366E8A1211364E90AA492F820D620F7ECCEB8,
        //     data_EXP: 2048'h10001,
        //     data_N: 2048'hDBC6686641E484AD414CAC014AA5735FE6BC4382438EDBDA4E0B0712E03D2E0058A64126828D0A9157B761B563469BA4388B06D4D3EF129DF72F98806C141E049D8A7AED75063BF585F6F26F04E2A6060C41FC3336FC0D6C316DBEF1DE4E16AE095F470404A15298089BCB9EFB6F71FB903374D9B2C1849BF805780278DFC49D2C801D0BB6EEDD7B3445BDF3D6F14BE26E408DBC2B65FFA9F74882929378E7F52C1837BD35AF9EF346CFB93E4ADBE96245BEBBF260416C82B2E6EC5073294D64DFAAF29084EDDCADE68BE1BBE4387F4EE0D1297B44F553EB03EBFA2589592F74ADCD29BB961AE1A32BCB00F5793F132B552CDE09A829CFF240A5F85EB30B9467,
        //     data_R2N: 2048'h5F1BAFAEF256B913445FE4514483574C86782E756C82038423AB46592E99C34E85F1A4F59070588F214AED12F0A479EBDE82ACF55CA7C29D5501691DEBC736A4E57A88B2BC6463F151C7F6F9355862AB56E258B3B161DBB6663568B19D8C70B1D2CD9AE9ADA2F0907E8C01D3C388CC73A96E0DFFB75A1F0E168D932794D27811F6B59A7531C3BAF8D68C5CA763407C3602E466BD2155BF5D77CD0360F2BDBE60949B72DF09B72AEDE8CB9F1D0FAF40929831A8E9C292E69D06576E9751EF3C228DD3C6F1BE06E716BC6E86AC483DBB8D3DA82855E8FB45653A3B8296E414F141F1C7774E2E38C1D36154A21083D99F28E0A7823CFD10F86398D35C6C55627C06});
        // Ifc_exponent#(2048,128) rsa_mod <- mk_exponent(rg_inp);
        // rule rl_start(!rdy);
        //     rsa_mod.ma_start();
        //     rdy <= True;
        //     $display("Start");
        // endrule

        // rule rl_get_result (rdy);
        //     if(rsa_mod.mv_outp_ready) begin
        //         let lv_temp <- rsa_mod.mav_result();
        //         $display($time, "Result:  %h", lv_temp);
        //         $finish(0);
        //     end
        // endrule

        Reg#(MultiplierInput#(2048)) rg_inp <- mkReg(MultiplierInput{
            data_A: 2048'h3EF8F0B6A84A7C9F60C53609493A6E5D97550553669A8FF328051AD8918A29A7C714E0F32DDC5C12097C53F50EAE335EEF73081E66D54AC2334C278E016417DD9E562BFA43B11E3913B923D6162F0D9D0779D53EE54C2CC7F7A57982DE24755209FCF142CC0062DC51F0567FDD21312CCEE613EFF40597E20980E8E2E7972067D771ED20A7DFCA15727B777A243E19335404A6DBB0FBAC64D73AC9F1436E40BED14745E6DFC26C8BB7813901CB1D9FF2FFE49D72C542E7DB928DF7E46F7CBB54C60862B1FFDEA43767956F1C8F46F0952E5BAA83FCA5ADB92C9C555E1160648F97B129E1FA121B20BFAA7631E79366E8A1211364E90AA492F820D620F7ECCEB8,
            data_B: 2048'h10001,
            data_M: 2048'hDBC6686641E484AD414CAC014AA5735FE6BC4382438EDBDA4E0B0712E03D2E0058A64126828D0A9157B761B563469BA4388B06D4D3EF129DF72F98806C141E049D8A7AED75063BF585F6F26F04E2A6060C41FC3336FC0D6C316DBEF1DE4E16AE095F470404A15298089BCB9EFB6F71FB903374D9B2C1849BF805780278DFC49D2C801D0BB6EEDD7B3445BDF3D6F14BE26E408DBC2B65FFA9F74882929378E7F52C1837BD35AF9EF346CFB93E4ADBE96245BEBBF260416C82B2E6EC5073294D64DFAAF29084EDDCADE68BE1BBE4387F4EE0D1297B44F553EB03EBFA2589592F74ADCD29BB961AE1A32BCB00F5793F132B552CDE09A829CFF240A5F85EB30B9467
        });

        Ifc_multiplier#(2048, 128) mul_mod <- mk_multiplier(rg_inp);

        rule rl_start(!rdy);
            mul_mod.ma_start();
            rdy <= True;
            $display("Start");
        endrule: rl_start

        rule rl_get_result (rdy);
            if(mul_mod.mv_outp_ready) begin
                let lv_temp <- mul_mod.mav_result();
                $display($time, "Result:  %h", lv_temp);
                $finish(0);
            end
        endrule: rl_get_result
    endmodule
endpackage: TB