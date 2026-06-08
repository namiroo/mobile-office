-- ============================================================
-- CESCO 수정 권한 정책 추가 (services / companies 편집용)
-- 사용법: Supabase 대시보드 → SQL Editor 에 붙여넣고 "Run"
-- ⚠️ 프로토타입용으로 누구나 수정 가능(using true). 실서비스에서는
--    로그인 사용자(auth.role() = 'authenticated') 기준으로 좁히세요.
-- ============================================================

drop policy if exists "update services (demo)"  on services;
drop policy if exists "insert services (demo)"  on services;
drop policy if exists "update companies (demo)" on companies;
drop policy if exists "insert companies (demo)" on companies;

create policy "update services (demo)"  on services  for update using (true) with check (true);
create policy "insert services (demo)"  on services  for insert with check (true);
create policy "update companies (demo)" on companies for update using (true) with check (true);
create policy "insert companies (demo)" on companies for insert with check (true);
