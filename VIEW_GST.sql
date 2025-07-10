CREATE OR REPLACE VIEW VIEW_GST AS
select sm.codefor,
       decode(b.tax_rate, null, 'HEAD', 'BODY') data_from,
       h.entity_code,
       b.div_code,
       h.tcode,
       h.vrno,
       H.TOKENNO,
       h.vrdate,
       h.acc_code,
       h.addon_code,
       h.consignee_code,
       b.cost_code,
       h.broker_code,
       h.trpt_code,
       h.truckno,
       h.lrno,
       h.lrdate,
       h.partybillno,
       h.partybilldate,
       h.partybillamt,
       NVL(B.TAX_CODE,h.stax_code) STAX_CODE,
       b.item_code item_code,
       b.qtyrecd,
       b.qtyissued,
       b.reachedqty,
       b.partyqty,
       b.cramt,
       b.dramt,
       h.acc_vrno,
       h.acc_tcode,
       h.trantype,
       b.slno,
       b.stock_type,
       cm.tnature,
       cm.tnature tnature_code,
       B.afield1,
       b.rate rate,
       m.state_code state_code,
       m.tin_no tinno,
       m.acc_sch,
       h.app_remark,
       atn.vrdate acc_vrdate,
       substr(acc_vrno, 1, 2) acc_series,
       to_char(h.vrdate,'MON-RRRR') month,
       substr(h.vrno,1,2) series,

       h.currency_code,
       h.from_place,
       h.to_place,
       b.rate_um,
       b.aum,
       b.um,
       b.apartyqty,
       b.areachedqty,
       b.aqtyissued,
       b.aqtyrecd,
       b.qtybilled,
       b.godown_code,
       item_group,
       im.item_catg,
       lhs_utility.get_name('item_catg',item_catg) item_catg_name,
       lhs_utility.get_name('item_group',item_group) item_group_name,
       lhs_utility.get_name('item_Code',b.item_code) item_name,
       h.waybillno,
       im.excise_tariff_code,
       im.item_nature,
       nvl(atn.revacc_code,decode(b.tcode,
                                  'M',b.post_acc_code,
                                  nvl(post_acc_code,lhs_acc.get_post_code(b.entity_code,b.div_code,h.acc_tcode,h.acc_vrno,cm.acc_year,im.item_group,h.trantype,b.stock_type,null))
                                 )
          ) post_code,
          NULL REV_ACC_CODE,
      ------GST COLUMN START---

      H.delivery_from_slno,
      H.delivery_to_slno,
      H.consignee_address_slno,
      B.tax_rate,
      B.tax_amount,
      B.tax_onamount,
      B.TAX_RATE1,
      B.tax_rate2,
      B.TAX_AMOUNT1,
      B.tax_amount2,
      NVL(B.GST_CODE,IM.gst_code) GST_CODE,
(select nvl(a.company,a.acc_name) from view_address_mast a where slno=H.delivery_from_slno ) From_Acc_name,
(select  nvl(a.company,a.acc_name)from view_address_mast a where slno=H.delivery_to_slno ) to_Acc_name,
(select a.gstinno from view_address_mast a where slno=H.delivery_from_slno ) Delivery_From_GSTINNO,
(select a.gstinno from view_address_mast a where slno=H.delivery_to_slno ) Delivery_to_GSTINNO,
(select a.state_name from view_address_mast a where slno=H.delivery_from_slno ) GST_From_state,
(select a.state_name from view_address_mast a where slno=H.delivery_to_slno ) GST_to_state,
(select a.gst_state_code from view_address_mast a where slno=H.delivery_from_slno) GST_From_state_code,
(select a.gst_state_code from view_address_mast a where slno=H.delivery_to_slno ) GST_to_state_code,
(select ADD1||' '||ADD2||' '||ADD3||' '||city from view_address_mast a where slno=H.delivery_from_slno ) GST_From_add,
(select ADD1||' '||ADD2||' '||ADD3||' '||city from view_address_mast a where slno=H.delivery_to_slno ) GST_to_add,
(select PAger from view_address_mast a where slno=H.delivery_from_slno ) GST_From_pan,
(select pager from view_address_mast a where slno=H.delivery_to_slno ) GST_to_pan,
(select a.gstinno from view_address_mast a where slno=H.Consignee_Address_Slno ) Consignee_GSTINNO,
(select a.state_name from view_address_mast a where slno=H.Consignee_Address_Slno ) Consignee_state,
(select a.gst_state_code from view_address_mast a where slno=H.Consignee_Address_Slno ) Consignee_state_code,
(select ADD1||' '||ADD2||' '||ADD3||' '||city from view_address_mast a where slno=H.Consignee_Address_Slno ) Consignee_add,
(select pager from view_address_mast a where slno=H.Consignee_Address_Slno ) Consignee_pan,
(select decode (a.gstin_type,'R','Register(R)','U','Un-Register(U)','C','Register Under Composition(C)','Not Applicable(N)') from view_address_mast a where slno=H.delivery_from_slno) from_gstin_type,
(select  decode (a.gstin_type,'R','Register(R)','U','Un-Register(U)','C','Register Under Composition(C)','Not Applicable(N)') from view_address_mast a where slno=H.delivery_to_slno ) to_gstin_type,
lhs_utility.get_addon_post_code(h.addon_code,h.vrdate,'SGST')SGST_POST_CODE,
lhs_utility.get_addon_post_code(h.addon_code,h.vrdate,'CGST')CGST_POST_CODE,
lhs_utility.get_addon_post_code(h.addon_code,h.vrdate,'IGST')IGST_POST_CODE,
lhs_utility.get_addon_post_code(h.addon_code,h.vrdate,'CESS')CESS_POST_CODE,

CASE WHEN SM.CODEFOR IN ('T') THEN
  TAX_AMOUNT
ELSE
  NULL
END SGST_AMOUNT,
CASE WHEN SM.CODEFOR IN ('T') THEN
  TAX_AMOUNT1
ELSE
  NULL
END CGST_AMOUNT,
CASE WHEN SM.CODEFOR IN ('K') THEN
  TAX_AMOUNT1
ELSE
  NULL
END IGST_AMOUNT,
CASE WHEN SM.CODEFOR IN ('T') THEN
  TAX_RATE
ELSE
  NULL
END SGST_RATE,
CASE WHEN SM.CODEFOR IN ('T') THEN
  TAX_RATE1
ELSE
  NULL
END CGST_RATE,
CASE WHEN SM.CODEFOR IN ('K') THEN
  TAX_RATE1
ELSE
  NULL
END IGST_RATE
-----GST COLUMN END ---

from   itemtran_head h,
       itemtran_body b,
       config_mast   cm,
       stax_mast     sm,
       item_mast     im,
       acc_tran      atn,
       acc_mast      m
where  instr('#S#Y#M#P#J#B', h.acc_tcode) <> 0
and    h.entity_code = b.entity_code
and    h.tcode = b.tcode
and    h.vrno = b.vrno
and    h.entity_code = cm.entity_code
and    h.acc_tcode = cm.tcode
and    substr(h.acc_vrno, 1, 4) = cm.series || substr(cm.acc_year, 1, 2)
and    h.entity_code = atn.entity_code
and    h.acc_tcode = atn.tcode
and    h.acc_vrno = atn.vrno
and    h.acc_slno = atn.slno
and    h.acc_code = m.acc_code
and    atn.vrdate between lhs_utility.get_from_date and lhs_utility.get_to_date
and NVL(B.TAX_CODE,H.STAX_CODE) = sm.stax_code/*(+)*/
and b.item_code = im.item_code(+)

UNION ALL

SELECT s.codefor,
'ACC_TRAN' data_from,
a.entity_code,
a.div_code,
a.tcode,
a.vrno,
a.TOKENNO,
a.vrdate,
a.acc_code,
NULL addon_code,
NULL consignee_code,
NULL cost_code,
NULL broker_code,
NULL trpt_code,
NULL truckno,
NULL lrno,
NULL lrdate,
NULL partybillno,
NULL partybilldate,
NULL partybillamt,
a.stax_code,
NULL item_code,
a.qtyrecd,
a.qtyissued,
NULL reachedqty,
NULL partyqty,
a.cramt,
a.dramt,
a.vrno acc_vrno,
a.tcode acc_tcode,
NULL trantype,
a.slno,
NULL stock_type,
a.tnature,
null tnature_code,
NULL afield1,
NULL rate,
NULL state_code,
NULL tinno,
NULL acc_sch,
null app_remark,
a.vrdate acc_vrdate,
NULL acc_series,
NULL month,
a.series,
a.currency_code,
NULL from_place,
NULL to_place,
NULL rate_um,
null aum,
null um,
NULL apartyqty,
NULL areachedqty,
NULL aqtyissued,
NULL aqtyrecd,
NULL qtybilled,
NULL godown_code,
NULL item_group,
NULL item_catg,
NULL item_catg_name,
NULL item_group_name,
NULL item_name,
NULL waybillno,
NULL excise_tariff_code,
NULL item_nature,
NULL post_code,
 lhs_acc.get_revacc_code(a.ENTITY_CODE,a.TCODE,a.vrno,a.slno,a.BASE_TCODE,a.ACC_cODE,a.dramt,a.cramt,a.REVACC_CODE)  rev_acc_code,
a.delivery_from_slno,
a.delivery_to_slno,
NULL consignee_address_slno,
NULL tax_rate,
NULL tax_amount,
NULL tax_onamount,
NULL tax_rate1,
NULL tax_rate2,
NULL tax_amount1,
NULL tax_amount2,
a.gst_code,
null from_acc_name,
null to_acc_name,
a.delivery_from_gstinno,
a.delivery_to_gstinno,
a.gst_from_state,
a.gst_to_state,
a.gst_from_state_code,
a.gst_to_state_code,
null gst_from_add,
null gst_to_add,
null gst_from_pan,
null gst_to_pan,
NULL consignee_gstinno,
NULL consignee_state,
NULL consignee_state_code,
NULL consignee_add,
NULL consignee_pan,
a.from_gstin_type,
a.to_gstin_type,
null sgst_post_code,
null cgst_post_code,
null igst_post_code,
NULL cess_post_code,
(case when s.codefor ='T'  then case when (instr(nvl((select get_gst_post_code_str('A','SGST') from dual),'#'),a.acc_code)<>0 or instr(nvl((select get_gst_post_code_str('B','SGST') from dual),'#'),a.acc_code)<>0 ) then  a.dramt else null end end)  Sgst_amount,
(case when s.codefor ='T'  then case when (instr(nvl((select get_gst_post_code_str('A','CGST') from dual),'#'),a.acc_code)<>0 or instr(nvl((select get_gst_post_code_str('B','CGST') from dual),'#'),a.acc_code)<>0 ) then  a.dramt else null end end)  cgst_amount,
(case when s.codefor ='K'  then case when (instr(nvl((select get_gst_post_code_str('A','IGST') from dual),'#'),a.acc_code)<>0 or instr(nvl((select get_gst_post_code_str('B','IGST') from dual),'#'),a.acc_code)<>0 ) then  a.dramt else null end end) igst_amount,
(case when s.codefor ='T'  then lhs_utility.get_gst_item_rate(A.entity_code,A.acc_code,null,A.gst_code,A.delivery_from_slno,A.vrdate,'SGST_RATE',A.STAX_CODE) end)  sgst_rate,
(case when s.codefor ='T'  then lhs_utility.get_gst_item_rate(A.entity_code,A.acc_code,null,A.gst_code,A.delivery_from_slno,A.vrdate,'CGST_RATE',A.STAX_CODE) end)  Cgst_rate,
(case when s.codefor ='K'  then lhs_utility.get_gst_item_rate(A.entity_code,A.acc_code,null,A.gst_code,A.delivery_from_slno,A.vrdate,'IGST_RATE',A.STAX_CODE) end)  Igst_rate
FROM VIEW_ACC_TRAN_ENGINE A , stax_mast s
where a.stax_code=s.stax_code
AND A.TNATURE IN ('BANK','CASH','JRNL')

