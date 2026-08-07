// Opaque id prefixing so user (member/library_staff) and loan (book_request/book_issue)
// records from two different tables can round-trip through the same API shape.

const parseUserId = (id) => {
  const s = String(id);
  if (s.startsWith('mem_'))   return { table: 'member', rawId: Number(s.slice(4)) };
  if (s.startsWith('staff_')) return { table: 'library_staff', rawId: Number(s.slice(6)) };
  throw new Error('Invalid user id');
};

const memId   = (id) => `mem_${id}`;
const staffId = (id) => `staff_${id}`;

const parseLoanId = (id) => {
  const s = String(id);
  if (s.startsWith('req_')) return { table: 'book_request', rawId: Number(s.slice(4)) };
  if (s.startsWith('iss_')) return { table: 'book_issue', rawId: Number(s.slice(4)) };
  throw new Error('Invalid loan id');
};

const reqId = (id) => `req_${id}`;
const issId = (id) => `iss_${id}`;

module.exports = { parseUserId, memId, staffId, parseLoanId, reqId, issId };
