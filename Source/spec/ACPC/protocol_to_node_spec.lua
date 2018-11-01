_G.myglobal = false
require 'ACPC.protocol_to_node'

describe('ACPC.protocol_to_node class', function()

  it('should parse correctly ACPC protocol message', function()

    local protocol_to_node = ACPCProtocolToNode()
    local state_str = "MATCHSTATE:0:99:cc/r8146:KhKs|/As4s8s"

    local state = protocol_to_node:parse_state(state_str)

    assert.are.equal(state.position, 1)
    assert.are.equal(state.hand_number, '99')
    assert.are.equal(state.hand_id, 1128)
    assert.are.equal(state.board, 'As4s8s')
    assert.are.equal(state.hand_string, 'KhKs')
    assert.are.equal(state.current_street, 2)

  end)
end)

