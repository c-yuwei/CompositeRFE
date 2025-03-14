%% ¡header!
ETC_calc_1 < ETC_calc_0 (et, test C calculate) tests calculate.

%%% ¡description!
ETC_calc_1 tests the update of calculate.

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ST_R (result, string) is a prop result string.
%%%% ¡calculate!
value = 'result calculated by ETC_calc_1';

%%% ¡prop!
ST_Q (query, string) is a prop query string.
%%%% ¡calculate!
value = 'query calculated by ETC_calc_1';

%%% ¡prop!
ST_E (evanescent, string) is a prop evanescent string.
%%%% ¡calculate!
value = 'evanescent calculated by ETC_calc_1';

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Update Calculate
%%%% ¡probability!
.01
%%%% ¡code!
et = ETC_calc_1();

assert(isequal(et.get('ST_R'), 'result calculated by ETC_calc_1'))
assert(isa(et.getr('ST_R'), 'NoValue'))
assert(isequal(et.memorize('ST_R'), 'result calculated by ETC_calc_1'))
assert(~isa(et.getr('ST_R'), 'NoValue'))

assert(isequal(et.get('ST_Q'), 'query calculated by ETC_calc_1'))
assert(isa(et.getr('ST_Q'), 'NoValue'))
warning('off', [BRAPH2.STR ':ETC_calc_1'])
assert(isequal(et.memorize('ST_Q'), 'query calculated by ETC_calc_1'))
warning('on', [BRAPH2.STR ':ETC_calc_1'])
assert(~isa(et.getr('ST_Q'), 'NoValue'))

warning('off', [BRAPH2.STR ':ETC_calc_1'])
assert(isequal(et.get('ST_E'), 'evanescent calculated by ETC_calc_1'))
warning('on', [BRAPH2.STR ':ETC_calc_1'])
assert(isa(et.getr('ST_E'), 'NoValue'))
assert(isequal(et.memorize('ST_E'), 'evanescent calculated by ETC_calc_1'))
assert(~isa(et.getr('ST_E'), 'NoValue'))
