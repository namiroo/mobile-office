-- ============================================================
-- CESCO 모바일 오피스 — Supabase 테이블 + 시드 데이터
-- 사용법: Supabase 대시보드 → SQL Editor → 아래 전체 붙여넣고 "Run"
-- 프로젝트: vmifsciiproqceimvrvi (my-academy 와 같은 프로젝트를 공유)
-- ============================================================

-- ── 1) 주요 서비스 ────────────────────────────────────────
create table if not exists services (
  id   bigint generated always as identity primary key,
  ic   text not null,          -- 아이콘(이모지)
  nm   text not null,          -- 이름
  n    integer default 0,      -- 알림 배지 숫자
  sort integer default 0       -- 정렬 순서
);

-- ── 2) 업체(SOL 플래너 / DE) ──────────────────────────────
create table if not exists companies (
  id     text primary key,       -- s1, s2, de1 ...
  scope  text not null default 'sol',  -- 'sol' 또는 'de'
  cls    text default '',         -- 카드 색상 클래스(ins/chk/as 등)
  nm     text not null,
  type   text,
  badge  text,                    -- b-run / b-wait / b-ok / b-err
  st     text,                    -- 상태 라벨(진행중/대기/완료/긴급)
  mgr    text,
  addr   text,
  phone  text,
  cycle  text,
  "next" text,
  "last" text,
  equip  text
);

-- ── 3) 협력업체 작업 ──────────────────────────────────────
create table if not exists partner_tasks (
  id      text primary key,       -- p1, p2 ...
  cls     text default '',
  type    text,
  badge   text,
  st      text,
  nm      text not null,
  cust    text,
  "date"  text,
  addr    text,
  equip   text,
  contact text,
  memo    text
);

-- ── 보안(RLS) ────────────────────────────────────────────
-- 프로토타입: 누구나 읽기 허용. partner_tasks 는 데모를 위해 수정도 허용.
-- ⚠️ 실서비스 전환 시에는 로그인 사용자 기준 정책으로 좁히세요.
alter table services      enable row level security;
alter table companies     enable row level security;
alter table partner_tasks enable row level security;

drop policy if exists "read services"      on services;
drop policy if exists "read companies"     on companies;
drop policy if exists "read partner_tasks" on partner_tasks;
drop policy if exists "update partner_tasks (demo)" on partner_tasks;

create policy "read services"      on services      for select using (true);
create policy "read companies"     on companies     for select using (true);
create policy "read partner_tasks" on partner_tasks for select using (true);
create policy "update partner_tasks (demo)" on partner_tasks for update using (true) with check (true);

-- ── 시드 데이터 (현재 프로토타입 목업 그대로) ─────────────
insert into services (ic, nm, n, sort) values
  ('📋','영업일지',0,1),('🤝','계약관리',2,2),('🏢','고객사',0,3),('📅','방문일정',4,4),
  ('💳','견적/청구',0,5),('📈','실적현황',0,6),('🧪','서비스',1,7),('📞','고객문의',3,8)
on conflict do nothing;

insert into companies (id, scope, cls, nm, type, badge, st, mgr, addr, phone, cycle, "next", "last", equip) values
  ('s1','sol','',   '스타벅스 강남R점','정기 방제','b-run','진행중','김세코','서울 강남구 테헤란로 152','02-555-0101','월 2회','2026.06.02','2026.05.19','포충등 4 · 트랩 12'),
  ('s2','sol','ins','롯데마트 잠실점','설치','b-wait','대기','김세코','서울 송파구 올림픽로 240','02-555-0202','신규','2026.06.02','-','IoT 모니터링 신규 8'),
  ('s3','sol','chk','CGV 용산아이파크','점검','b-ok','완료','박기술','서울 용산구 한강대로23길 55','02-555-0303','월 1회','2026.06.30','2026.06.01','쥐덫 20 · 연막 2'),
  ('s4','sol','as', '그린푸드 1공장','AS','b-err','긴급','박기술','경기 화성시 동탄산단로 88','031-555-0404','수시','2026.06.02','2026.05.28','방충망 · 에어커튼 6'),
  ('de1','de','',   '한빛아파트 101동','정기 방제','b-run','진행중','박기술','서울 노원구 동일로 1234','02-555-0505','월 1회','오늘 09:30','2026.05.02','공동현관 트랩 6'),
  ('de2','de','',   '그린푸드 공장','긴급 방역','b-err','긴급','박기술','경기 화성시 동탄산단로 88','031-555-0404','수시','오늘 11:00','2026.05.28','연막 4 · 잔류분무'),
  ('de3','de','',   '메가몰 지하주차장','설치 점검','b-wait','대기','박기술','서울 강서구 마곡중앙로 100','02-555-0606','분기','오늘 14:30','2026.03.15','포충등 12')
on conflict (id) do nothing;

insert into partner_tasks (id, cls, type, badge, st, nm, cust, "date", addr, equip, contact, memo) values
  ('p1','ins','설치','b-run','진행중','IoT 방제 센서 설치','롯데마트 잠실점','06.02 10:00','서울 송파구 올림픽로 240','스마트 트랩 8대','현장 김주임 010-1234-5678','지하 식품관 우선 설치. 전원 콘센트 위치 사전 확인 필요.'),
  ('p2','chk','점검','b-wait','대기','정기 장비 점검','CGV 용산','06.03 14:00','서울 용산구 한강대로23길 55','포충등 6대 · 쥐덫 20','시설 이과장 010-2222-3333','상영관 운영 외 시간(오전) 점검 권장.'),
  ('p3','as','AS','b-err','긴급','에어커튼 오작동 AS','그린푸드 1공장','06.02 16:00','경기 화성시 동탄산단로 88','에어커튼 2대','관리 박부장 010-4444-5555','입고장 에어커튼 풍압 저하. 부품 교체 가능성 — 모터 모듈 지참.')
on conflict (id) do nothing;
