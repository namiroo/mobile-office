/* =====================================================================
 * Supabase 연동 설정
 * ---------------------------------------------------------------------
 * 1) 아래 anonKey 에 anon public 키를 붙여넣으세요.
 *    대시보드 → Project Settings → API → Project API keys → anon public
 * 2) tables 에 실제 테이블 이름을 맞춰주세요. (아래는 예시 가정)
 *
 *  ⚠️ 이 키는 공개 키이지만, 모든 테이블에 RLS가 켜져 있어야 안전합니다.
 * ===================================================================== */
window.SUPABASE_CONFIG = {
  url: 'https://vmifsciiproqceimvrvi.supabase.co',

  // anon(publishable) 공개 키. (my-academy 프로젝트와 공유)
  anonKey: 'sb_publishable_WbGwEtZRMFYCPRTvSiRdhA_tm16_o4J',

  // 아직 Supabase Auth 사용자가 없어 false. 사용자 생성 후 true 로 바꾸면 로그인 화면이 뜹니다.
  requireLogin: false,

  // 실제 테이블 이름으로 맞춰주세요. (컬럼은 현재 목업 키와 동일하다고 가정)
  tables: {
    services: 'services',          // 컬럼: ic, nm, n, sort
    companies: 'companies',        // 컬럼: id, cls, nm, type, badge, st, mgr, addr, phone, cycle, next, last, equip, scope('sol'|'de')
    partnerTasks: 'partner_tasks'  // 컬럼: id, cls, type, badge, st, nm, cust, date, addr, equip, contact, memo
  }
};
